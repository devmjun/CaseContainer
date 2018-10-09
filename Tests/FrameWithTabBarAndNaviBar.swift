//
//  FrameWithTabBarAndNaviBar.swift
//  Tests
//
//  Created by minjuniMac on 10/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example 

class FrameWithTabBarAndNaviBar: XCTestCase {

    var sut: DemoViewController!
    var naviBarHeight: CGFloat!
    var tabBarHeight: CGFloat!
    var statusBarHeight = UIApplication.shared.statusBarFrame.height
    
    
    override func setUp() {
        super.setUp()
        let tabBarController = UITabBarController()
        let naviBarController = UINavigationController(rootViewController: DemoViewController())
        naviBarController.isNavigationBarHidden = false
        sut = naviBarController.viewControllers.first as? DemoViewController
        tabBarController.viewControllers = [naviBarController]
        
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
        _ = sut.view
        sut.v.layoutIfNeeded()
        
        tabBarHeight = sut.tabBarController?.tabBar.frame.height
        naviBarHeight = sut.navigationController?.navigationBar.frame.height
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ContainerScrollViewFrame_Is_ValidWhen_bothIsVisible() {
        let y = statusBarHeight + naviBarHeight
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - (y + tabBarHeight)
        
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        
        XCTAssertEqual(sut.v.containerScrollView.frame, rect)
    }
    func test_ContentScrollViewFrame_Is_ValidWhen_bothIsVisible() {
        let headerHeight = sut.v.headerView.frame.height
        let tabScrollViewHeight = sut.v.tabScrollView.frame.height
        let y = statusBarHeight + naviBarHeight + headerHeight + tabScrollViewHeight
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - (statusBarHeight + naviBarHeight + tabScrollViewHeight + tabBarHeight)
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        let convertOrigin = sut.v.contentsScrollView.convert(sut.v.frame.origin, to: sut.v)
        let convertRect = CGRect(
            origin: convertOrigin, size: sut.v.contentsScrollView.frame.size)
        
        XCTAssertEqual(convertRect, rect)
        XCTAssertEqual(sut.v.contentsScrollView.contentSize, sut.v.horizonCanvasView.frame.size)
        
    }
}
