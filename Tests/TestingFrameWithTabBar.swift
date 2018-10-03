//
//  TestingFrameWithTabBar.swift
//  Tests
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example 
//class TestingFrameWithTabBar: XCTestCase {
//    
//    var sut: DemoViewController!
//    var tabBarHeight: CGFloat!
//    var statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
//    override func setUp() {
//        super.setUp()
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [DemoViewController()]
//        
//        sut = tabBarController.viewControllers?.first as? DemoViewController
//        UIApplication.shared.keyWindow?.rootViewController = tabBarController
//        _ = sut.view
//        sut.v.layoutIfNeeded()
//        
//        tabBarHeight = sut.tabBarController?.tabBar.frame.height
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        sut = nil
//        super.tearDown()
//    }
//    
//    func test_ContainerScrollViewFrame_Is_ValidWhenTabBarIsVisible() {
//        // 2
//        let y: CGFloat = UIApplication.shared.statusBarFrame.height
//        let width = UIScreen.mainWidth
//        let height = UIScreen.mainHeight - (y + tabBarHeight)
//        let rect = CGRect(x: 0, y: y, width: width , height: height)
//        
//        // 3
//        XCTAssertEqual(sut.v.containerScrollView.frame, rect)
//    }
//    
//    func test_ContentScrollViewFrameIsValidWhenTabBarIsVisible() {
//        let tabScrollViewHeight = sut.v.tabScrollView.frame.height
//        let headerHeight = sut.v.headerView.frame.height
//        let y = statusBarHeight + headerHeight + tabScrollViewHeight
//        let contentScrollViewFrameHeight = UIScreen.mainHeight - (statusBarHeight + tabScrollViewHeight + tabBarHeight)
//        let rect = CGRect(x: 0, y: y, width: UIScreen.mainWidth, height: contentScrollViewFrameHeight)
//        
//        let convertContentScrollViewRect = sut.v.contentsScrollView.convert(sut.v.contentsScrollView.bounds, to: sut.v)
//        
//        XCTAssertEqual(convertContentScrollViewRect, rect)
//    }
//}
