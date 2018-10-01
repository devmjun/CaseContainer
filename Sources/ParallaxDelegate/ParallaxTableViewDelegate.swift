//
//  ParallaxTableViewDelegate.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

public protocol ParallaxTableViewDelegate: class {
    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView)
}

extension CaseContainerViewController: ParallaxTableViewDelegate {
    /// scrolling top and bottom is synchronized
    public func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView) {
        let scrollingUp: Bool = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
        var childScrollingDownDueToParent = false
        let maxiumParallaxY = headerView.frame.height
        
        if scrollingUp {
            if scrollView == tableView {
                if v.containerScrollView.contentOffset.y < maxiumParallaxY && !childScrollingDownDueToParent {
                    v.containerScrollView.contentOffset.y = max(
                        min(v.containerScrollView.contentOffset.y + tableView.contentOffset.y, maxiumParallaxY), 0)
                    tableView.contentOffset.y = 0
                }
            }
        } else {
            if scrollView == tableView {
                if tableView.contentOffset.y < 0 && v.containerScrollView.contentOffset.y > 0 {
                    v.containerScrollView.contentOffset.y = max(v.containerScrollView.contentOffset.y - abs(tableView.contentOffset.y), 0)
                }
            }
            
            if scrollView == v.containerScrollView {
                if tableView.contentOffset.y > 0 && v.containerScrollView.contentOffset.y < maxiumParallaxY {
                    childScrollingDownDueToParent = true
                    tableView.contentOffset.y = max(tableView.contentOffset.y - (maxiumParallaxY - v.containerScrollView.contentOffset.y), 0)
                    v.contentsScrollView.contentOffset.y = maxiumParallaxY
                    childScrollingDownDueToParent = false
                }
            }
        }
        
//        let progress = containerScrollView.contentOffset.y / maxiumParallaxY
//        delegate?.caseContainer?(parallaxHeader: progress)
    }
}


