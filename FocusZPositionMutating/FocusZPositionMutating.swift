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

extension UIView {
    @objc func fzpm_didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let me = self as? FocusZPositionMutating {
            me.applyCoordinatedZPositionState(context: context, coordinator: coordinator)
        }
    }
    public static func fzpm_swizzleDidUpdateFocus() {
        let instance = UIView()
        let method: Method = class_getInstanceMethod(object_getClass(instance), #selector(didUpdateFocus(in:with:)))!
        let swizzledMethod: Method = class_getInstanceMethod(object_getClass(instance), #selector(fzpm_didUpdateFocus(in:with:)))!
        method_exchangeImplementations(method, swizzledMethod)
    }
}


private var intermediateZPosition: CGFloat = 0.5
private var workItem: DispatchWorkItem?
private func triggerResetSharedVariable() {
    workItem?.cancel()
    workItem = DispatchWorkItem {
        intermediateZPosition = 0.5
    }
    if let workItem = workItem {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: workItem)
    }
}

extension FocusZPositionMutating where Self: UIView {
    public func applyCoordinatedZPositionState(context: UIFocusUpdateContext, coordinator: UIFocusAnimationCoordinator) {
        var completion: (() -> ())?
        if let next = context.nextFocusedView, next.isDescendant(of: self) {
            self.layer.zPosition = 1.0
        } else if let previous = context.previouslyFocusedView, previous.isDescendant(of: self) {
            intermediateZPosition += 0.000001
            print(intermediateZPosition)
            self.layer.zPosition = intermediateZPosition
            completion = {
                if let f = UIScreen.main.focusedView, !f.isDescendant(of: self) {
                    self.layer.zPosition = 0.0
                    triggerResetSharedVariable()
                }
            }
        }
        coordinator.addCoordinatedAnimations(nil, completion: completion)
    }
}
