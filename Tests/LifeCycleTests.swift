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
        sut = DemoViewController()
        _ = sut.v
        sut.v.layoutIfNeeded()
        UIApplication.shared.keyWindow?.rootViewController = sut
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_CallingDeinit() {
        let mockDemoViewController = MockDemoViewController()
        sut = mockDemoViewController
        self.sut = nil
        let expectation = XCTestExpectation()
        XCTWaiter.wait(for: [expectation], timeout: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
            XCTAssertTrue(mockDemoViewController.isCalledDeinit)
        }
    }
}

extension LifeCycleTests {
    class MockDemoViewController: DemoViewController {
        var isCalledDeinit: Bool = false
        deinit {
            isCalledDeinit = true
        }
    }
}
