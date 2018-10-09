//
//  Tests.swift
//  Tests
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example

class FrameTests: XCTestCase {
    
    var sut: DemoViewController!
    var statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    let width = UIScreen.mainWidth
    var headerHeight: CGFloat!
    var tabScrollViewHeight: CGFloat!
    
    override func setUp() {
        sut = DemoViewController()
        UIApplication.shared.keyWindow?.rootViewController =  sut
        _ = sut.v
        sut.v.layoutIfNeeded()
        
        headerHeight = sut.v.headerView.frame.height
        tabScrollViewHeight = sut.v.tabScrollView.frame.height
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    
    func test_ContainerScrollViewFrame_Is_ValidWhenInitializing() {
        // 1
        let y: CGFloat = statusBarHeight
        let height = UIScreen.mainHeight - y
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width , height: height)
        
        // 3
        XCTAssertEqual(sut.v.containerScrollView.frame, rect)
    }
    
    func test_verticalCanvasFrameIsValidWhenInitializing() {
        // 1
        let contentScrollViewHeight = sut.v.contentsScrollView.frame.height
        let verticalCanvasHeight = headerHeight + tabScrollViewHeight + contentScrollViewHeight
        
        // 2
        let rect = CGRect(x: 0, y: 0, width: width, height: verticalCanvasHeight)
        
        // 3
        XCTAssertEqual(sut.v.verticalCanvasView.frame, rect)
        XCTAssertEqual(sut.v.containerScrollView.contentSize, sut.v.verticalCanvasView.frame.size)
    }
    
    func test_TabScrollViewFrameIsValidWhenInitializing() {
        XCTAssertEqual(sut.appearence.tabScrollHegiht, sut.v.tabScrollView.frame.height)
    }
    
    func test_ContentScrollViewFrameIsValidWhenInitializing() {
        // 1
        let contentScrollViewFrameHeight = UIScreen.mainHeight - (statusBarHeight + tabScrollViewHeight)
        let y = statusBarHeight + headerHeight + tabScrollViewHeight
        
        let rect = CGRect(
            x: 0, y: y,
            width: width, height: contentScrollViewFrameHeight)
        
        // 2
        let convertRect = sut.contentsScrollView.convert(sut.v.contentsScrollView.bounds, to: sut.v)
        XCTAssertEqual(convertRect, rect)
        
        // 3
        let contentWidth = UIScreen.mainWidth * CGFloat(sut.viewContorllers.count)
        let contentHeight = convertRect.size.height
        let contentSize = CGSize(width: contentWidth, height: contentHeight)
        XCTAssertEqual(sut.v.horizonCanvasView.frame.size, contentSize)
    }
}
