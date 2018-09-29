//
//  LifeCycleTests.swift
//  Tests
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import XCTest
@testable import Example 
class LifeCycleTests: XCTestCase {
    
    var sut: DemoViewController!
    override func setUp() {
        super.setUp()
        sut = DemoViewController()
        _ = sut.v
        sut.v.layoutIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = sut
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_CallingDeinit() {
        let expectation = XCTestExpectation()
        sut = MockDemoViewController()
        (sut as? MockDemoViewController)?.calledDeinit = {
            expectation.fulfill()
        }
        sut = nil
        UIApplication.shared.keyWindow?.rootViewController = nil
        
        wait(for: [expectation], timeout: 2)
    }
}

extension LifeCycleTests {
    class MockDemoViewController: DemoViewController {
        var calledDeinit: (() -> Void)?
        deinit { calledDeinit?() }
    }
}


