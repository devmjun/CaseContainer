//
//  ParallaxCollectionViewController.swift
//  Example
//
//  Created by minjuniMac on 03/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

open class ParallaxCollectionViewController: UICollectionViewController {
    weak open var delegate: ParallaxViewDelegate?
    
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView: scrollView, tableViewAndCollectionView: collectionView)
    }
}
