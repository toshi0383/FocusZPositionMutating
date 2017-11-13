//
//  ViewController.swift
//  ViewTransformSample
//
//  Created by Toshihiro Suzuki on 2017/11/13.
//  Copyright © 2017 toshi0383. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items: [String] = (0..<100).map { "\($0)" }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}
