//
//  UnfocusableCell.swift
//  FocusZPositionMutating
//
//  Created by Toshihiro Suzuki on 2017/11/13.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import FocusZPositionMutating
import UIKit

//class UnfocusableCell: UICollectionViewCell {
class UnfocusableCell: UICollectionViewCell, FocusZPositionMutating {
    override var canBecomeFocused: Bool {
        return false
    }
}
