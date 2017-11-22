//
//  MultipleCollectionViewController.swift
//  Example
//
//  Created by Toshihiro Suzuki on 2017/11/22.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import FocusZPositionMutating
import UIKit

class ZPositionCollectionView: UICollectionView, FocusZPositionMutating { }

final class MultipleCollectionViewController: UIViewController {
    @IBOutlet private weak var collectionView1: UICollectionView!
    @IBOutlet private weak var collectionView2: UICollectionView!
    @IBOutlet private weak var collectionView3: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView1.dataSource = DataSource.shared
        collectionView2.dataSource = DataSource.shared
        collectionView3.dataSource = DataSource.shared
    }
}
