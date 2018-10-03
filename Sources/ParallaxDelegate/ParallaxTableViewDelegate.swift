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
        let direction: Direction = scrollingUp ? .up : .down
        var childScrollingDownDueToParent = false
        let maxiumParallaxY = headerView.frame.height
        
        switch direction {
        case .left: fallthrough
        case .right: fallthrough
        case .up:
            if scrollView == tableView {
                if v.containerScrollView.contentOffset.y < maxiumParallaxY && !childScrollingDownDueToParent {
                    let offsetY = max(min(v.containerScrollView.contentOffset.y + tableView.contentOffset.y, maxiumParallaxY), 0)
                    v.containerScrollView.contentOffset.y = offsetY
                    tableView.contentOffset.y = 0
                    v.headerView.frame.origin.y = offsetY * 0.5
                }
            }
            
        case .down:
            if scrollView == tableView {
                if tableView.contentOffset.y < 0 && v.containerScrollView.contentOffset.y > 0 {
                    let offsetY = max(v.containerScrollView.contentOffset.y - abs(tableView.contentOffset.y), 0)
                    v.containerScrollView.contentOffset.y = offsetY
                    v.headerView.frame.origin.y = offsetY * 0.5
                }
            }
            
            if scrollView == v.containerScrollView {
                if tableView.contentOffset.y > 0 && v.containerScrollView.contentOffset.y < maxiumParallaxY {
                    childScrollingDownDueToParent = true
                    let offsetY = max(tableView.contentOffset.y - (maxiumParallaxY - v.containerScrollView.contentOffset.y), 0)
                    tableView.contentOffset.y = offsetY
                    v.contentsScrollView.contentOffset.y = maxiumParallaxY
                    childScrollingDownDueToParent = false
                    v.headerView.frame.origin.y = offsetY * 0.5
                }
            }
        }
    }
}


