//
//  SMViewController.swift
//  SMParallaxView
//
//  Created by OLEKSANDR SEMENIUK on 6/12/18.
//  Copyright © 2018 OLEKSANDR SEMENIUK. All rights reserved.
//

import UIKit

class SMViewController: UIViewController {
    
    lazy var dataSource: [SMViewModel] = SMViewModel.createDemoModels()
}

extension SMViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SMCollectionViewCell.self), for: indexPath) as! SMCollectionViewCell
        
        cell.paralaxView.images = dataSource[indexPath.row].images
        
        return cell
    }
}

extension SMViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width - 40.0, height: collectionView.frame.size.width/1.5)
    }
}

