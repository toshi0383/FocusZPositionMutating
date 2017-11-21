//
//  CollectionViewController.swift
//  Example
//
//  Created by Toshihiro Suzuki on 2017/11/21.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController {
    private let items: [Int] = (0..<1000).map { $0 }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = "TEXTTEXT TEXTTEXT \(items[indexPath.item])"
        return cell
    }
}

final class CollectionViewCell: FocusableZPositionCell {
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .gray
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView == self {
            backgroundColor = .white
        } else {
            backgroundColor = .gray
        }
        super.didUpdateFocus(in: context, with: coordinator)
    }
}
