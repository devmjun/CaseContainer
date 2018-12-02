//
//  CaseContainerView.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

open class CaseContainerView: CaseContainerBaseView<CaseContainerViewController> {
    public private(set) var containerScrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        /// was specified unidirection Scrolling, this direction of scrollView is vertical
        $0.isDirectionalLockEnabled = true
        $0.bounces = true
        
        /// height of scrollView's contentSize is adjusted in iPhoneX' seriess(iPhoneX, iPhone XS, iPhone XR...). I didn't want to this Behavior
        if #available(iOS 11, *) {
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    /**
     This property is containerScrollView's contentView
     */
    public private(set) var verticalCanvasView = UIView().then {
        $0.backgroundColor = .white
    }
    
    public var headerView: UIView = UIView().then {
        $0.backgroundColor = .white
    }
    
    public var tabScrollView = TabScrollView()
    
    public var contentsScrollView = UIScrollView().then {
        $0.bounces = true
        $0.backgroundColor = .white
        $0.isDirectionalLockEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        
        if #available(iOS 11, *) {
            $0.contentInsetAdjustmentBehavior = .never
        }
    }
    
    /**
     This propery is ContentsScrollView's Content View
     */
    lazy public private(set) var horizonCanvasView = UIView().then {
        let rect = CGRect(
            x: 0, y: 0,
            width: ui.contentsScrollViewContentSize.width,
            height: ui.contentsScrollViewContentSize.height)
        $0.frame = rect
        $0.backgroundColor = .white
    }
    
    private var tabBarHeight: CGFloat {
        guard let homeIndicator = UIApplication.shared.windows.first,
            let tabBarController = vc.tabBarController else {
                return 0
        }
        var tabBarHeight = tabBarController.tabBar.frame.height
        
        if #available(iOS 11.0, *) {
            let homeIndicatorHeight = homeIndicator.safeAreaInsets.bottom
            // MARK: issues: having different Value at the same point when having UINavigationBar or not having UINavigationBar
            // temporary expedient at not.
            // in iPhoneX serise, UITabBarController.TabBar Height is 49 when having only UITabBarController but UITabBarController.TabBar Height is 49 + 34(home Indicator's height) when having both UITabBarController and UINavigationController.
            // the same instance has different value at the same point. I don't know reason. now(2018.10.10)
            // and when having UINavigationController.navigationBar, to be forced safe area constraint in the bottom
            tabBarHeight = tabBarHeight > 50 ? (tabBarHeight - homeIndicatorHeight) : tabBarHeight
            return tabBarHeight + homeIndicatorHeight
        } else {
            return tabBarHeight
        }
    }
    
    private var navigationBarHeight: CGFloat {
        guard let navigationController = vc.navigationController,
            let height = vc.navigationController?.navigationBar.frame.size.height,
            navigationController.isNavigationBarHidden == false ||
                navigationController.navigationBar.isHidden == false else {
                    return 0
        }
        return height
    }
    
    public struct UI {
        var headerViewHeight: CGFloat
        var tabScrollViewHeight: CGFloat
        var contentsScrollViewFrameSize: CGSize
        var contentsScrollViewContentSize: CGSize
        var containerScrollViewContentSize: CGSize
        
        init(containerViewController: CaseContainerViewController,
             headerHeight: CGFloat,
             tabScrollHeaight: CGFloat,
             tabBarHeight: CGFloat,
             naviBarHeight: CGFloat) {
            guard containerViewController.viewContorllers.count > 0 else {
                #if targetEnvironment(simulator)
                fatalError("you must Implement ChildViewController")
                #else
                headerViewHeight = 0
                tabScrollViewHeight = 0
                contentsScrollViewFrameSize = CGSize.zero
                contentsScrollViewContentSize = CGSize.zero
                containerScrollViewContentSize = CGSize.zero
                return 
                #endif
            }
            let numberOfChildVierControlelr: CGFloat = CGFloat(containerViewController.viewContorllers.count)
            headerViewHeight = headerHeight
            tabScrollViewHeight = tabScrollHeaight
            
            contentsScrollViewFrameSize = CGSize(
                width: UIScreen.mainWidth,
                height: UIScreen.mainHeight - (UIApplication.statusBarHeight + tabScrollViewHeight + tabBarHeight + naviBarHeight))
            
            contentsScrollViewContentSize = CGSize(
                width: UIScreen.mainWidth * numberOfChildVierControlelr,
                height: contentsScrollViewFrameSize.height)
            
            containerScrollViewContentSize = CGSize(
                width: UIScreen.mainWidth,
                height: headerViewHeight + tabScrollViewHeight + contentsScrollViewFrameSize.height)
            
        }
    }
    
    public private(set) lazy var ui = UI(
        containerViewController: vc,
        headerHeight: vc.appearence.headerHeight,
        tabScrollHeaight: vc.appearence.tabScrollHegiht,
        tabBarHeight: tabBarHeight,
        naviBarHeight: navigationBarHeight)
    
    
    override func setupUI() {
        backgroundColor = .white
        /*
         ⎮ View
         ⎮ -- containerScrollView
         ⎮ ---- verticalCanvasView
         ⎮ ------ headerView
         ⎮ ------ tabCollectionView
         ⎮ ------ contentsScrollView
         ⎮ -------- horizonCanvasView
         ⎮ ---------- vc.children.view
         ⎮ ---------- vc.children.view1
         ⎮ ----------- ...
         */
        addSubviews([containerScrollView])
        containerScrollView.addSubview(verticalCanvasView)
        contentsScrollView.addSubview(horizonCanvasView)
        verticalCanvasView.addSubviews([headerView, tabScrollView, contentsScrollView])
        
        containerScrollView
            .topAnchor(to: topAnchor, constant: UIApplication.statusBarHeight + navigationBarHeight)
            .leadingAnchor(to: leadingAnchor)
            .trailingAnchor(to: trailingAnchor)
            .bottomAnchor(to: bottomAnchor, constant: -tabBarHeight)
            .activateAnchors()
        
        verticalCanvasView
            .topAnchor(to: containerScrollView.topAnchor)
            .bottomAnchor(to: containerScrollView.bottomAnchor)
            .leadingAnchor(to: containerScrollView.leadingAnchor)
            .trailingAnchor(to: containerScrollView.trailingAnchor)
            .dimensionAnchors(size: ui.containerScrollViewContentSize)
            .activateAnchors()
        
        headerView
            .topAnchor(to: verticalCanvasView.topAnchor)
            .leadingAnchor(to: verticalCanvasView.leadingAnchor)
            .trailingAnchor(to: verticalCanvasView.trailingAnchor)
            .heightAnchor(constant: ui.headerViewHeight)
            .activateAnchors()
        
        tabScrollView
            .topAnchor(to: headerView.bottomAnchor)
            .leadingAnchor(to: verticalCanvasView.leadingAnchor)
            .trailingAnchor(to: verticalCanvasView.trailingAnchor)
            .heightAnchor(constant: ui.tabScrollViewHeight)
            .activateAnchors()
        
        contentsScrollView
            .topAnchor(to: tabScrollView.bottomAnchor)
            .leadingAnchor(to: verticalCanvasView.leadingAnchor)
            .trailingAnchor(to: verticalCanvasView.trailingAnchor)
            .heightAnchor(constant: ui.contentsScrollViewFrameSize.height)
            .activateAnchors()
        
        /// ViewControllers that are added on initilization add parent ViewController's childViewController
        guard vc.viewContorllers.count > 0 else {
            #if targetEnvironment(simulator)
            fatalError("You must be to add container view controller's child view controller when it is initializaed")
            #else
            return
            #endif
        }
        
        vc.viewContorllers.forEach {
            guard $0.title != nil else {
                #if targetEnvironment(simulator)
                fatalError("You must be to add viewControllers`s title when it is initialized")
                #else
                return
                #endif 
            }
        }
        
        setupChildViewController(of: vc.viewContorllers)
    }
    
    override func setupBinding() {
        containerScrollView.contentSize = ui.containerScrollViewContentSize
        contentsScrollView.contentSize = ui.contentsScrollViewContentSize
        
        containerScrollView.delegate = vc
        contentsScrollView.delegate = vc
        tabScrollView.delegate = vc
        
        tabScrollView.setupBinding(parent: vc, ui: ui)
        assigningResotrationIDToChildVC()
    }
    
    func setupChildViewController(of childViewControllers: [UIViewController]) {
        guard let initialChildVC = childViewControllers.first else {
            return
        }
        // 1. Add child Viewcontroller into ContainerViewControlelr
        vc.addChild(initialChildVC)
        
        // 2. add child ViewController's view into ContainerViewController view
        horizonCanvasView.addSubview(initialChildVC.view)
        
        // 3. determine child View Controller`s view frame
        if initialChildVC is ParallaxTableViewController ||
            initialChildVC is ParallaxCollectionViewController {
            initialChildVC.view.frame = CGRect(x: 0, y: 0, width: ui.contentsScrollViewFrameSize.width, height: ui.contentsScrollViewContentSize.height)
        }else {
            // if it is not ParallaxTableViewController
            let vaildViewHeight = UIScreen.mainHeight - UIApplication.statusBarHeight
            let scaleRatio = ui.contentsScrollViewContentSize.height / vaildViewHeight
            initialChildVC.view.transform = CGAffineTransform(scaleX: 1.0, y: scaleRatio)
            initialChildVC.view.layer.frame.origin = CGPoint.zero
        }
        initialChildVC.didMove(toParent: vc)
    }
    
    private func assigningResotrationIDToChildVC() {
        vc.viewContorllers.forEach {
            $0.restorationIdentifier = UUID().uuidString
        }
    }
}


