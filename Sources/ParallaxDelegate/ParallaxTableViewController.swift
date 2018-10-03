//
//  ParallaxTableViewController.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

open class ParallaxTableViewController: UITableViewController {
    weak open var delegate: ParallaxViewDelegate?
    
    open override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView: scrollView, tableViewAndCollectionView: tableView)
    }
}


