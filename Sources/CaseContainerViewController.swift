//
//  CaseContainerViewController.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

public enum Direction {
    case left
    case right
    case up
    case down
}

open class CaseContainerViewController: CaseContainerBaseViewController {
    
    lazy open private(set) var v = CaseContainerView(controllBy: self)
    weak open var delegate: CaseContainerDelegate?
    
    
    open weak var tabScrollView: TabScrollView! { return v.tabScrollView }
    open weak var contentsScrollView: UIScrollView! { return v.contentsScrollView }
    open weak var containerScrollView: UIScrollView! { return v.containerScrollView }
    
    open override func loadView() {
        view = v
    }
    
    fileprivate struct _ScrollViewStatus{
        var currentIndex: CGFloat = 0
        var originIndex: CGFloat = 0
        var startDraggingOffsetX: CGFloat?
    }
    
    private var scrollViewStatus = _ScrollViewStatus()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// didSelect TabButton
    @objc func tabButtonAction(_ sender: TabButton) {
        let index = sender.tag
        if let currentVC = children.first,
            let currentViewControllerIdnex = viewControllerIndex(currentVC),
            currentViewControllerIdnex != index {
            UIView.animate(withDuration: 0.25) {
                let contentsWidth = Int(UIScreen.mainWidth)
                self.v.tabScrollView.reload(index)
                self.v.contentsScrollView.setContentOffset(
                    CGPoint(x: contentsWidth * index, y: 0),animated: false)
            }
            
            scrollViewStatus.currentIndex = CGFloat(index)
            buttonHighlight(index)
            buttonDehighlightWithout(index)
            removeAllWithout(index)
            goTo(index)
            
            delegate?.caseContainer(
                caseContainerViewController: self,
                didSelectTabButton: sender,
                prevIndex: currentViewControllerIdnex,
                index: index)
        }
    }
    
    var preventingException: Bool = false {
        willSet {
            contentsScrollView.isUserInteractionEnabled = newValue
        }
    }
    
    /// synchronizeing ScrollView and Child ViewControlelr
    open func prevIndex(n: Int?) -> Int? { return n! - 1 }
    open func nextIndex(n: Int?) -> Int? { return n! + 1 }
    
    func viewControllerIndex(_ viewController: UIViewController) -> Int? {
        return viewContorllers.index(of: viewController)
    }
    
    /**
     Adds the specified view controller as a child of the current(ContainerVC) view controller.
     */
    open func goTo(_ index: Int) {
        if index >= 0 && index < viewContorllers.count {
            if let childVC = viewContorllers.at(index) {
                addChild(childVC)
                v.horizonCanvasView.addSubview(childVC.view)
                let indexWidth: CGFloat = v.ui.contentsScrollViewFrameSize.width
                let rect = CGRect(
                    x: indexWidth * CGFloat(index), y: 0,
                    width: indexWidth, height: v.ui.contentsScrollViewContentSize.height)
                childVC.view.frame = rect
                
                childVC.didMove(toParent: self)
                childVC.beginAppearanceTransition(true, animated: true)
                childVC.endAppearanceTransition()
            }
        }
    }
    
    /**
     this mothod delete All of the current ChildViewControllers with excepting of ChildViewController at `index`
     */
    open func removeAllWithout(_ index: Int?) {
        children
            .forEach { [weak self] (childVC: UIViewController) in
                guard let strongSelf = self else { return }
                let activeChildVC = strongSelf.viewContorllers.at(index)
                if childVC != activeChildVC {
                    childVC.willMove(toParent: nil)
                    childVC.view.removeFromSuperview()
                    childVC.removeFromParent()
                    childVC.beginAppearanceTransition(false, animated: true)
                    childVC.endAppearanceTransition()
                }
        }
    }
    
    open func buttonHighlight(_ index: Int) {
        v.tabScrollView.buttons[index].status = .on
    }
    /**
     this method dehighlight All of the highlighted buttons with excepting of a button at `index`
     */
    open func buttonDehighlightWithout(_ index: Int) {
        v.tabScrollView.buttons
            .enumerated()
            .forEach { [weak self] (offset: Int, btn: TabButton) in
                guard let strongSelf = self else { return }
                let currentIndex = Int(strongSelf.scrollViewStatus.currentIndex)
                if currentIndex != offset {
                    btn.status = .off
                }
        }
    }
}

/// ChildViewController 's lifeCycle in ContainerViewController
extension CaseContainerViewController {
    open override var shouldAutomaticallyForwardAppearanceMethods: Bool { return false }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        children.forEach { $0.beginAppearanceTransition(true, animated: true) }
        
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        children.forEach { $0.endAppearanceTransition() }
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        children.forEach { $0.beginAppearanceTransition(false, animated: true) }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        children.forEach { $0.endAppearanceTransition() }
    }
}

extension CaseContainerViewController {
    /* infered width of number of String*/
    open func inferIntrinsicCellWidth(_ string: String?) -> CGFloat {
        let label = UILabel()
        label.text = string
        let visibleWidthSafeGuard: CGFloat = 18
        return label.intrinsicContentSize.width + visibleWidthSafeGuard /* this point is Cell Width*/
    }
}


extension CaseContainerViewController: UIScrollViewDelegate {
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView === v.contentsScrollView && scrollView !== v.tabScrollView   {
            scrollViewStatus.startDraggingOffsetX = scrollView.contentOffset.x
            /// prevent TabScrollView's indicator from getting out of doing before updating - 1
            preventingException = false
        }
        
        delegate?.caseContainer(
            caseContainerViewController: self,
            scrollViewWillBeginDragging: scrollView)
        
    }
    
    /* scrolling left and right are synchronized  */
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentsWidth = UIScreen.mainWidth
        let direction = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        let offsetX = scrollView.contentOffset.x
        
        if scrollView === v.contentsScrollView && direction > 0 ||
            direction < 0 && scrollView !== v.tabScrollView { /* explicitly, Call the scrollview because it uses a nested scrollView */
            // Switch Index when more than 50% of the previous/next page is visible
            scrollViewStatus.currentIndex = floor( (offsetX - contentsWidth / 2) / contentsWidth ) + 1
            scrollViewStatus.originIndex = floor( (offsetX - contentsWidth) / contentsWidth ) + 1
            
            if let _startDraggingOffsetX = scrollViewStatus.startDraggingOffsetX,
                let presentedChildVC = children.first {
                
                let forward = _startDraggingOffsetX < offsetX /* true is going to nextPage, false is going to previous Page */
                let percent = (offsetX - _startDraggingOffsetX) / scrollView.bounds.width * 1.1
                let percentComplete = forward == false ? (1.0 - percent) - 1.0 : percent
                let _percentComplete =  min(1.0, percentComplete)
                
                if let index = forward ? nextIndex(n: viewControllerIndex(presentedChildVC)): prevIndex(n: viewControllerIndex(presentedChildVC)) ,
                    index < viewContorllers.count && index > -1 {
                    
                    let direction: Direction = forward ? .right : .left
                    switch direction {
                    case .left:
                        v.tabScrollView.scrollingLeft(
                            index: index,
                            progress: _percentComplete,
                            scrollView: scrollView)
                    case .right:
                        v.tabScrollView.scrollingRight(
                            index: index,
                            progress: _percentComplete,
                            scrollView: scrollView)
                    case .up: break
                    case .down: break
                    }
                    
                    delegate?.caseContainer(
                        caseContainerViewController: self,
                        progress: _percentComplete,
                        index: Int(scrollViewStatus.originIndex),
                        scrollViewDidScroll: scrollView)
                    guard children.count < 2 else { return }
                    goTo(index)
                    view.layoutIfNeeded()
                }
            } else {
                if scrollView.isDragging {
                    scrollViewStatus.startDraggingOffsetX = ceil(scrollView.contentOffset.x)
                }
            }
        }
//        else if scrollView === containerScrollView {
//            let maxiumOffsetY = v.headerView.frame.height
//            let progress = containerScrollView.contentOffset.y / maxiumOffsetY
//            
//            // temporarily...
//            // To synchronize the contentOffset of the child view controller, contentOffset of the container ScrollView
//            if progress == 0 {
//                viewContorllers.forEach {
//                    if $0 is ParallaxTableViewController {
//                        ($0 as? ParallaxTableViewController)?.tableView.contentOffset = CGPoint.zero
//                    }
//                }
//            }
//            delegate?.caseContainer(parallaxHeader: progress)
//            
//        }
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.caseContainer(
            caseContainerViewController: self,
            index: Int(scrollViewStatus.originIndex),
            scrollViewDidEndDragging: scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let direction = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        
        if scrollView === v.contentsScrollView &&
            direction > 0 || direction < 0 &&
            scrollView !== v.tabScrollView { /* explicitly, Call the scrollview because it uses a nested scrollView */
            // 1
            scrollViewStatus.startDraggingOffsetX = nil
            let contentsWidth = UIScreen.mainWidth
            let currentIndex = Int(scrollViewStatus.currentIndex)
            let contentOffsetX = scrollView.contentOffset.x
            
            // 2
            scrollViewStatus.currentIndex = floor( (contentOffsetX - contentsWidth / 2) / contentsWidth ) + 1
            v.tabScrollView.reload(currentIndex)
            
            // 3
            buttonHighlight(currentIndex)
            buttonDehighlightWithout(currentIndex)
            
            // 4. Delete all ChildViewControllers Without the current index's viewController
            removeAllWithout(currentIndex)
            
            // exception
            if children.count == 0 {
                goTo(currentIndex)
            }
        }
        
        /// prevent TabScrollView's indicator from getting out of doing before updating - 1
        preventingException = true
        
        delegate?.caseContainer(
            caseContainerViewController: self,
            index: Int(scrollViewStatus.currentIndex),
            scrollViewDidEndDecelerating: scrollView)
    }
}





