//
//  FocusableView.swift
//  ViewTransformSample
//
//  Created by Toshihiro Suzuki on 2017/11/13.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import FocusZPositionMutating
import UIKit

class FocusableView: UIView {
    override var canBecomeFocused: Bool {
        return true
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if context.nextFocusedView == self {
                self.transform = .init(scaleX: 1.3, y: 1.3)
            } else {
                self.transform = .identity
            }
        }, completion: nil)
        super.didUpdateFocus(in: context, with: coordinator)
    }
}

class FocusableZPositionView: FocusableView, FocusZPositionMutating { }
class FocusableZPositionCell: UICollectionViewCell, FocusZPositionMutating {
    override var canBecomeFocused: Bool {
        return true
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            if context.nextFocusedView == self {
                self.transform = .init(scaleX: 1.3, y: 1.3)
            } else {
                self.transform = .identity
            }
        }, completion: nil)
        super.didUpdateFocus(in: context, with: coordinator)
    }
}
