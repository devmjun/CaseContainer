//
//  CaseContainerDelegate.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
@objc public protocol CaseContainerDelegate: class {
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        scrollViewWillBeginDragging scrollView: UIScrollView)
    
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        progress: CGFloat,
        index: Int,
        scrollViewDidScroll scrollView: UIScrollView)
    
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDragging scrollView: UIScrollView)
    
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDecelerating scrollView: UIScrollView)
    
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        didSelectTabButton tabButton: TabButton,
        prevIndex: Int,
        index: Int)
    
    @objc optional func caseContainer(parallaxHeader progress: CGFloat)
}

