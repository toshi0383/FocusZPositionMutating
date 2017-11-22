//
//  DataSource.swift
//  Example
//
//  Created by Toshihiro Suzuki on 2017/11/22.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import UIKit

final class DataSource: NSObject, UICollectionViewDataSource {
    static let shared = DataSource()
    private override init() { }
    private let items: [Int] = (0..<1000).map { $0 }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = "TEXTTEXT TEXTTEXT \(items[indexPath.item])"
        return cell
    }
}
