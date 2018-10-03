//
//  FrameTests.swift
//  Tests
//
//  Created by minjuniMac on 03/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example

class FrameTests: XCTestCase {

    var sut: DemoViewController!
    var statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DemoViewController()
        UIApplication.shared.keyWindow?.rootViewController = sut
        _ = sut.v
        sut.v.layoutIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_ContainerScrollViewFrame_Is_ValidWhenInitializing() {
        // 1
        let y: CGFloat = statusBarHeight
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - y
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width , height: height)
        
        // 3
        XCTAssertEqual(sut.v.containerScrollView.frame, rect)
        XCTAssertEqual(sut.v.containerScrollView.contentSize, rect.size)
    }
    
    func test_TabBarScrollViewFrame_Is_ValidWhenInitializing() {
        // 1
        let y = statusBarHeight
        let width = UIScreen.mainWidth
        let height = sut.appearence.tabScrollHegiht
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        let convertOrigin = sut.v.tabScrollView.convert(sut.view.bounds.origin, to: sut.v)
        let convertRect = CGRect(
            origin: convertOrigin,
            size: sut.v.tabScrollView.frame.size)
        
        // 3
        XCTAssertEqual(convertRect, rect)
    }
    
    func test_ContentScrollViewFrame_IsValidWhenInitializing() {
        // 1
        let y = statusBarHeight + sut.tabScrollView.frame.height
        let width = UIScreen.mainWidth
        let height = UIScreen.mainHeight - y
        
        // 2
        let rect = CGRect(x: 0, y: y, width: width, height: height)
        let convertOrigin = sut.v.contentsScrollView.convert(sut.view.bounds.origin, to: sut.v)
        let convertRect = CGRect(
            origin: convertOrigin,
            size: sut.v.contentsScrollView.frame.size)
        
        // 3
        XCTAssertEqual(convertRect, rect)
        
        let contentHeight = UIScreen.mainHeight - statusBarHeight
        let contentWidth = UIScreen.mainWidth * CGFloat(sut.viewContorllers.count)
        let contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        XCTAssertEqual(sut.v.contentsScrollView.contentSize, contentSize)
        
        
    }
    
    
    
}
