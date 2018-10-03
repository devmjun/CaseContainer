//
//  TabScrollView.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

open class TabScrollView: UIScrollView {
    public enum Status {
        case normal
        case largeThenScreen
    }
    
    open private(set) var status: Status = .normal
    
    open var _horizontalCanvas = UIView()
    var indicator: UIView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    
    
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
    func setupBinding(
        parent vc: CaseContainerViewController,
        ui: CaseContainerView.UI) {
        var buttonsWidth = vc.viewContorllers.map { return vc.inferIntrinsicCellWidth($0.title) }
        if buttonsWidth.reduce(0, +) <= UIScreen.mainWidth {
            let buttonsWholeWidth = buttonsWidth.reduce(0, +)
            let eachRatio = buttonsWidth.map { $0 / buttonsWholeWidth }
            buttonsWidth = eachRatio.map { $0 * UIScreen.mainWidth }
        }else {
            status = .largeThenScreen
        }
        
        for item in 0..<vc.viewContorllers.count {
            let rect = CGRect(
                x: buttonsWidth[..<item].reduce(0, +), y: 0,
                width: buttonsWidth[item], height: ui.tabScrollViewHeight)
            buttonsRect.append(rect)
        }

        contentSize = CGSize(
            width: buttonsWidth.reduce(0, +),
            height: ui.tabScrollViewHeight)
        
        _horizontalCanvas
            .topAnchor(to: topAnchor)
            .bottomAnchor(to: bottomAnchor)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .dimensionAnchors(size: contentSize)
            .activateAnchors()
        
        setupIndicator(
            firstSize: CGSize(width: buttonsWidth[0],
                              height: ui.tabScrollViewHeight))
        
        setupButtons(parent: vc)
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
    func setupButtons(parent vc: CaseContainerViewController) {
        let tabBarColor = vc.appearence.tabColor
        let indicatorColor = vc.appearence.indicatorColor
        
        let titles = vc.viewContorllers.compactMap { $0.title }
        for i in 0..<buttonsRect.count {
            let btn = TabButton(frame: buttonsRect[i])
            btn.setTitle("\(titles[i])", for: .normal)
            btn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
            btn.tag = i
            btn.normalColor = tabBarColor.normal
            btn.highLightedColor = tabBarColor.highLight
            btn.status = i == 0 ? .on : .off
            btn.addTarget(vc, action: #selector(vc.tabButtonAction(_:)), for: .touchUpInside)
            _horizontalCanvas.addSubview(btn)
            buttons.append(btn)
        }
        
        indicator.backgroundColor = indicatorColor
    }
    
    public func reload(_ index: Int) {
        guard index < self.buttonsRect.count else { return }
        let buttonRect = buttonsRect[index]
        let limitingValue = contentSize.width - UIScreen.mainWidth
        let convertOffsetX = (buttonRect.minX / 2 >= limitingValue) ? limitingValue : buttonRect.minX / 2
        
        indicator.layer.frame.origin.x = buttonRect.minX
        indicator.layer.frame.size.width = buttonRect.width
        contentOffset.x = status == .largeThenScreen ? convertOffsetX : 0
    }
    
    /**
     This method synchorized ContentsScrollView's Contents Offset and TabScrollView's indicator's Position and Width
     
     - Parameter index: an index is a 'previous' index than current position
     - Parameter progress: scrolling percent
     - Parameter scrollView: Contents ScrollView
     */
    public func scrollingLeft(index: Int, progress: CGFloat, scrollView: UIScrollView) {
        let contentScrollViewOriginX = scrollView.contentOffset.x
        let ratio = buttonsRect[index].width / UIScreen.mainWidth
        let originX = buttonsRect[index+1].origin.x
        let destination = UIScreen.mainWidth * CGFloat(index + 1)
        let convertOriginX = originX - (destination - contentScrollViewOriginX) * ratio
        
        let limitingValue = contentSize.width - UIScreen.mainWidth
        let convertOffsetX = (convertOriginX / 2 >= limitingValue) ? limitingValue : convertOriginX / 2
        
        indicator.layer.frame.origin.x = convertOriginX
        contentOffset.x = status == .largeThenScreen ? convertOffsetX : 0
        
        let prevButtonWidth = buttonsRect[index].width
        let currentButtonWidth = buttonsRect[index+1].width
        let differenceDistance = currentButtonWidth > prevButtonWidth ? true : false
        let convertWidth = prevButtonWidth * progress
        
        // If the current button's width is greater than the previous button's width
        if differenceDistance {
            if currentButtonWidth > prevButtonWidth {
                let decreaseValue = (currentButtonWidth - prevButtonWidth) * progress
                let newConvertWidth = currentButtonWidth - decreaseValue
                indicator.layer.frame.size.width = newConvertWidth
            }
            
            // If the current button's width is smaller than the previous button's width
        }else {
            if convertWidth >= currentButtonWidth {
                indicator.layer.frame.size.width = convertWidth
            }
        }
    }
    
    /**
     This method synchorized ContentsScrollView's Contents Offset and TabScrollView's indicator's Position and Width
     
     - Parameter index: an index is a 'next' index than current position
     - Parameter progress: scrolling percent
     - Parameter scrollView: Contents ScrollView
     */
    public func scrollingRight(index: Int, progress: CGFloat, scrollView: UIScrollView) {
        // synchronize indicator's origin.x
        let contentScrollViewOriginX = scrollView.contentOffset.x
        let ratio = buttonsRect[index-1].width / UIScreen.mainWidth
        let originX = buttonsRect[index].origin.x
        let destination = UIScreen.mainWidth * CGFloat(index)
        let convertOriginX = (contentScrollViewOriginX - destination) * ratio + originX
        
        let limitingValue = contentSize.width - UIScreen.mainWidth
        let convertOffsetX = (convertOriginX / 2 >= limitingValue) ? limitingValue : convertOriginX / 2
        
        indicator.layer.frame.origin.x = convertOriginX
        contentOffset.x = status == .largeThenScreen ? convertOffsetX : 0
        
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
                indicator.layer.frame.size.width = newConvertWidth
            }
            
            // If the current button's width is smaller then next button's width
            // Start resizing from the 'point' where the button's width you want to change is smaller than the current button's width
        }else {
            if convertWidth >= currentButtonWidth {
                indicator.layer.frame.size.width = convertWidth
            }
        }
    }
}

