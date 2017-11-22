//
//  FocusZPositionMutating.swift
//  ViewTransformSample
//
//  Created by Toshihiro Suzuki on 2017/11/13.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import UIKit

public protocol FocusZPositionMutating {
    func applyCoordinatedZPositionState(context: UIFocusUpdateContext, coordinator: UIFocusAnimationCoordinator)
}

public enum FZPMError: Error {
    case invalidParameter(String)
}

extension UIView {
    @objc func fzpm_didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let me = self as? FocusZPositionMutating {
            me.applyCoordinatedZPositionState(context: context, coordinator: coordinator)
        }
        fzpm_didUpdateFocus(in: context, with: coordinator)
    }
    @objc func fzpm_didMoveToSuperview() {
        if let _ = self as? FocusZPositionMutating {
            self.layer.zPosition = _unfocusedZPosition
        }
        fzpm_didMoveToSuperview()
    }
    public static func fzpm_swizzleDidUpdateFocus(focusedZPosition: CGFloat = 1.0, unfocusedZPosition: CGFloat = 0.0) throws {
        if focusedZPosition <= unfocusedZPosition + 0.1 {
            throw FZPMError.invalidParameter("focusedZPosition must be greater than unfocusedZPosition + 0.1")
        }
        _focusedZPosition = focusedZPosition
        _unfocusedZPosition = unfocusedZPosition
        intermediateZPosition = unfocusedZPosition + (focusedZPosition - unfocusedZPosition) / 2
        let instance = UIView()
        do {
            let method: Method = class_getInstanceMethod(object_getClass(instance), #selector(didUpdateFocus(in:with:)))!
            let swizzledMethod: Method = class_getInstanceMethod(object_getClass(instance), #selector(fzpm_didUpdateFocus(in:with:)))!
            method_exchangeImplementations(method, swizzledMethod)
        }
        do {
            let method: Method = class_getInstanceMethod(object_getClass(instance), #selector(didMoveToSuperview))!
            let swizzledMethod: Method = class_getInstanceMethod(object_getClass(instance), #selector(fzpm_didMoveToSuperview))!
            method_exchangeImplementations(method, swizzledMethod)
        }
    }
}
public var fzpm_isDebugEnabled: Bool = false
internal var _focusedZPosition: CGFloat = 1.0
internal var _unfocusedZPosition: CGFloat = 0.0
internal var intermediateZPosition: CGFloat = 0.5
private var workItem: DispatchWorkItem?
private func triggerResetSharedVariable() {
    workItem?.cancel()
    workItem = DispatchWorkItem {
        intermediateZPosition = intermediateZPosition
    }
    if let workItem = workItem {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: workItem)
    }
}

extension FocusZPositionMutating where Self: UIView {
    public func applyCoordinatedZPositionState(context: UIFocusUpdateContext, coordinator: UIFocusAnimationCoordinator) {
        var completion: (() -> ())?
        if let next = context.nextFocusedView, next.isDescendant(of: self) {
            self.layer.zPosition = _focusedZPosition
            log()
        } else if let previous = context.previouslyFocusedView, previous.isDescendant(of: self) {
            intermediateZPosition += 0.000001
            self.layer.zPosition = intermediateZPosition
            log()
            completion = {
                if let f = UIScreen.main.focusedView, !f.isDescendant(of: self) {
                    self.layer.zPosition = _unfocusedZPosition
                    self.log()
                    triggerResetSharedVariable()
                }
            }
        }
        coordinator.addCoordinatedAnimations(nil, completion: completion)
    }
    private func log() {
        guard fzpm_isDebugEnabled else { return }
        queuedPrint("[FZPM DEBUG] zPosition: \(self.layer.zPosition), self: \(self)")
    }
}

private let queue = DispatchQueue(label: "jp.toshi0383.FocusZPositionMutating")
private func queuedPrint(_ message: String) {
    queue.async {
        print(message)
    }
}
