//
//  CaseContainerDelegate.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
public protocol CaseContainerDelegate: class {
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        scrollViewWillBeginDragging scrollView: UIScrollView)
    
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        progress: CGFloat,
        index: Int,
        scrollViewDidScroll scrollView: UIScrollView)
    
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDragging scrollView: UIScrollView)
    
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDecelerating scrollView: UIScrollView)
    
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        didSelectTabButton tabButton: TabButton,
        prevIndex: Int,
        index: Int)
    
    func caseContainer(parallaxHeader progress: CGFloat)
}

