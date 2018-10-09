//
//  FrameWithNaviBarTests.swift
//  Tests
//
//  Created by minjuniMac on 10/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example

class FrameWithNaviBarTests: XCTestCase {

    var sut: DemoViewController!
    var naviBarHeight: CGFloat!
    var statusBarHegiht = UIApplication.shared.statusBarFrame.height
    
    override func setUp() {
        super.setUp()
        
        let naviBarController = UINavigationController(rootViewController: DemoViewController())
        naviBarController.isNavigationBarHidden = false
        sut = naviBarController.viewControllers.first as? DemoViewController
        
        UIApplication.shared.keyWindow?.rootViewController = naviBarController
        _ = sut.view
        sut.v.layoutIfNeeded()
        naviBarHeight = sut.navigationController?.navigationBar.frame.height
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil 
        super.tearDown()
    }
    
    // MARK: bug: in iPhoneX
    func test_ContainerScrollViewFrame_Is_ValidWhenNaviBarIsVisible() {
        // 1
        let y = statusBarHegiht + naviBarHeight
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - y
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        
        // 3
        XCTAssertEqual(sut.v.containerScrollView.frame, rect)
    }
    
    func test_ContentScrollViewFrameIsValidWhenNaviBarIsVisible() {
        // 1
        let headerHeight = sut.v.headerView.frame.height
        let tabScrollHeight = sut.v.tabScrollView.frame.height
        let y = statusBarHegiht + naviBarHeight + headerHeight + tabScrollHeight
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - (statusBarHegiht + naviBarHeight + tabScrollHeight)
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        let convertOrigin = sut.v.contentsScrollView.convert(sut.v.frame.origin, to: sut.v)
        let convertRect = CGRect(origin: convertOrigin, size: sut.v.contentsScrollView.frame.size)
        
        // 3
        XCTAssertEqual(convertRect, rect)
        XCTAssertEqual(sut.v.contentsScrollView.contentSize, sut.v.horizonCanvasView.frame.size)
    }


}
