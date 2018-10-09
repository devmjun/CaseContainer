//
//  CaseContainerDelegate.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
@objc public protocol CaseContainerDelegate: class {
    /**
     Tells the delegate when the Container scroll view is about to start scrolling the content.
     */
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        scrollViewWillBeginDragging scrollView: UIScrollView)
    
    /**
     Tells the delegate when the user scrolls the Container content view within the receiver.
     
     - Parameter index: A valid index of the Container view Controller's children. `index` must be less than `viewControllers.count`.
     */
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        progress: CGFloat,
        index: Int,
        scrollViewDidScroll scrollView: UIScrollView)
    
    /**
     Tells the delegate when dragging ended in the Container scroll view.
     
     - Parameter index: A valid index of the Container view Controller's children. `index` must be less than `viewControllers.count`.
     */
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDragging scrollView: UIScrollView)
    
    /**
     Tells the delegate that the Container scroll view has ended decelerating the scrolling movement
     
     - Parameter index: A valid index of the Container view Controller's children. `index` must be less than `viewControllers.count`.
     */
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDecelerating scrollView: UIScrollView)
    
    
    /**
     Tells the delegate when tabButton is clicked
     
     - Parameter tabButton: clicked button
     - Parameter prevIndex: the previous index of the clicked button
     - Parameter index: the current index of the Container view Controller's children. `index` must be less than `viewControllers.count`.
     */
    @objc optional func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        didSelectTabButton tabButton: TabButton,
        prevIndex: Int,
        index: Int)
    
    /**
     Tells the delegate When the header view is covered by the container scroll view
     
     - Parameter progress: A ratio of the header view's height currently
     */
    @objc optional func caseContainer(parallaxHeader progress: CGFloat)
}

