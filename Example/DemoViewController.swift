//
//  ViewController.swift
//  Example
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

import UIKit
import CaseContainer

class DemoViewController: CaseContainerViewController {
    
    var myValue: Int = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        delegate = self
    }
    
    required init() {
        super.init()
        let vc = ChildTableViewController()
        vc.title = "tabtab1"
        vc.delegate = self
        
        let vc1 = ChildTableViewController()
        vc1.title = "tabtab2"
        vc1.delegate = self
        
        let vc2 = ChildTableViewController()
        vc2.title = "tabtabtab3"
        vc2.delegate = self
        
        let vc3 = ChildTableViewController()
        vc3.title = "tabtabtabtabtab4"
        vc3.delegate = self
        
        let vc4 = ChildTableViewController()
        vc4.title = "tab5"
        vc4.delegate = self
        
        let vc5 = ChildTableViewController()
        vc5.title = "tabtabtabtabtabtab6"
        vc5.delegate = self
        
        // 1
        viewContorllers = [vc, vc1, vc2, vc3, vc4, vc5]
        
        
        // 2
        appearence = Appearence(
            headerViewHegiht: 300, tabScrollViewHeight: 50,
            indicatorColor: .green,
            tabButtonColor: (normal: .gray, highLight: .black))
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(maintain: [UIViewController], appearence: Appearence) {
        super.init(maintain: maintain, appearence: appearence)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    deinit { print("Called \(#function) at \(self)") }
    
    
    
}

extension DemoViewController {
}

extension DemoViewController: CaseContainerDelegate {
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        scrollViewWillBeginDragging scrollView: UIScrollView) {
        //        print("""
        //
        //            scrollViewWillBeginDragging!
        //            caseContainerViewController: \(caseContainerViewController)
        //            scrollView:\(scrollView)
        //
        //            """)
        
    }
    // 2
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        progress: CGFloat,
        index: Int,
        scrollViewDidScroll scrollView: UIScrollView) {
        //        print("""
        //
        //            scrollViewDidScroll
        //            caseContainerViewController: \(caseContainerViewController)
        //            progress: \(progress)
        //            index: \(index)
        //            scrollView:\(scrollView)
        //
        //            """)
        
    }
    
    // 3.
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDragging scrollView: UIScrollView) {
        //        print("""
        //
        //            scrollViewDidEndDragging
        //            caseContainerViewController: \(caseContainerViewController)
        //            index: \(index)
        //            scrollView:\(scrollView)
        //
        //            """)
        
    }
    
    // 4.
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDecelerating scrollView: UIScrollView) {
        //        print("""
        //
        //            scrollViewDidEndDecelerating
        //            caseContainerViewController: \(caseContainerViewController)
        //            scrollView:\(scrollView)
        //
        //            """)
        
    }
    
    // 5.
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        didSelectTabButton tabButton: TabButton,
        prevIndex: Int,
        index: Int) {
        //        print("""
        //
        //            didSelectTabButton: \(tabButton)
        //            caseContainerViewController: \(caseContainerViewController)
        //            prevIndex: \(prevIndex)
        //            index: \(index)
        //
        //            """)
        
    }
    
    func caseContainer(parallaxHeader progress: CGFloat) {
        //        print("progres: \(progress)")
    }
    
}

