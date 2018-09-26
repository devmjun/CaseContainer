//
//  TabScrollView.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

open class TabScrollView: UIScrollView {
    open var _horizontalCanvas = UIView()
    var indicator: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView(frame: CGRect.zero))
    
    public var buttonsRect = Array<CGRect>()
    open private(set) var buttons = Array<TabButton>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 1
    open func setupUI() {
        addSubview(_horizontalCanvas)
        _horizontalCanvas.addSubview(indicator)
        showsHorizontalScrollIndicator = false
        isDirectionalLockEnabled = true
        backgroundColor = .white
    }
    
    // 2
    open func delegateBy(_ owner: UIScrollViewDelegate) {
        delegate = owner
    }
    
    // 3
    open func setupIndicator(firstSize: CGSize) {
        let indicatorHeight: CGFloat = 2
        let y = firstSize.height - indicatorHeight
        let width = firstSize.width
        let rect = CGRect(x: 0, y: y, width: width, height: indicatorHeight)
        indicator.frame = rect
    }
    
    // 4
    func setupBinding(viewController: CaseContainerViewController, height: CGFloat) {
        let childVC = viewController.viewContorllers
        let tabBarColor = viewController.appearence.tabColor
        let indicatorColor = viewController.appearence.indicatorColor
        let contentWidth = buttonsRect.reduce(0){ $0 + $1.width } /* add button's Width + button1's  width.. */
        
        contentSize = CGSize(width: contentWidth, height: height)
        
        _horizontalCanvas
            .topAnchor(to: topAnchor)
            .bottomAnchor(to: bottomAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .dimensionAnchors(size: contentSize)
            .activateAnchors()
        
        let title = childVC.compactMap { $0.title }
        
        for i in 0..<buttonsRect.count {
            let btn = TabButton(frame: buttonsRect[i])
            btn.setTitle("\(title[i])", for: .normal)
            btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            btn.tag = i
            btn.normalColor = tabBarColor.normal
            btn.highLightedColor = tabBarColor.highLight
            btn.status = i == 0 ? .on : .off
            btn.addTarget(viewController, action: #selector(viewController.tabButtonAction(_:)), for: .touchUpInside)
            _horizontalCanvas.addSubview(btn)
            buttons.append(btn)
        }
        
        indicator.backgroundColor = indicatorColor
    }
    
    public func scrollingSynchronization(
        prevIndex: Int?, nextIndex: Int?,
        progress: CGFloat, scrollView: UIScrollView) {
        guard !(prevIndex == nil && nextIndex == nil) else { return }
        
        if let prev = prevIndex {
            scrollingLeft(index: prev, progress: progress, scrollView: scrollView)
        }
        if let next = nextIndex {
            scrollingRight(index: next, progress: progress, scrollView: scrollView)
        }
    }
    
    /**
     This method synchorized ContentsScrollView's Contents Offset and TabScrollView's indicator's Position and Width
     
     - Parameter index: an index is a 'previous' index than current position
     - Parameter progress: scrolling percent
     - Parameter scrollView: Contents ScrollView
     */
    private func scrollingLeft(index: Int, progress: CGFloat, scrollView: UIScrollView) {
        let contentScrollViewOriginX = scrollView.contentOffset.x
        let ratio = buttonsRect[index].width / UIScreen.mainWidth
        let originX = buttonsRect[index+1].origin.x
        let destination = UIScreen.mainWidth * CGFloat(index + 1)
        let convertOriginX = originX - (destination - contentScrollViewOriginX) * ratio
        
        indicator.frame.origin.x = convertOriginX
        contentOffset.x = convertOriginX / 2
        
        let prevButtonWidth = buttonsRect[index].width
        let currentButtonWidth = buttonsRect[index+1].width
        let differenceDistance = currentButtonWidth > prevButtonWidth ? true : false
        let convertWidth = prevButtonWidth * progress
        
        // If the current button's width is greater than the previous button's width
        if differenceDistance {
            if currentButtonWidth > prevButtonWidth {
                let decreaseValue = (currentButtonWidth - prevButtonWidth) * progress
                let newConvertWidth = currentButtonWidth - decreaseValue
                indicator.frame.size.width = newConvertWidth
            }
            
            // If the current button's width is smaller than the previous button's width
        }else {
            if convertWidth >= currentButtonWidth {
                indicator.frame.size.width = convertWidth
            }
        }
    }
    
    /**
     This method synchorized ContentsScrollView's Contents Offset and TabScrollView's indicator's Position and Width
     
     - Parameter index: an index is a 'next' index than current position
     - Parameter progress: scrolling percent
     - Parameter scrollView: Contents ScrollView
     */
    private func scrollingRight(index: Int, progress: CGFloat, scrollView: UIScrollView) {
        // synchronize indicator's origin.x
        let contentScrollViewOriginX = scrollView.contentOffset.x
        let ratio = buttonsRect[index-1].width / UIScreen.mainWidth
        let originX = buttonsRect[index].origin.x
        let destination = UIScreen.mainWidth * CGFloat(index)
        let convertOriginX = (contentScrollViewOriginX - destination) * ratio + originX
        
        indicator.frame.origin.x = convertOriginX
        contentOffset.x = convertOriginX / 2
        
        // Synchronize indicator's width
        let nextButtonWidth = buttonsRect[index].width
        let currentButtonWidth = buttonsRect[index-1].width
        let differenceDistance = currentButtonWidth >= nextButtonWidth ? true : false
        let convertWidth = nextButtonWidth * progress
        
        /// If the current button's width is greater then or equal next Button's width
        /// When the current button's width is equal next Button's width, It Do Nothing
        if differenceDistance {
            if currentButtonWidth > nextButtonWidth {
                let decreaseValue = (currentButtonWidth - nextButtonWidth) * progress
                let newConvertWidth = currentButtonWidth - decreaseValue
                indicator.frame.size.width = newConvertWidth
            }
            
            // If the current button's width is smaller then next button's width
            // Start resizing from the 'point' where the button's width you want to change is smaller than the current button's width
        }else {
            if convertWidth >= currentButtonWidth {
                indicator.frame.size.width = convertWidth
            }
        }
    }
}

