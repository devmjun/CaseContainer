//
//  ViewController.swift
//  Example
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
import CaseContainer

class DemoViewController: CaseContainerViewController {
    var dismissButton: UIButton = {
        let rect = CGRect(x: UIScreen.mainWidth - 50 , y: 44, width: 50, height: 50)
        var btn = UIButton(frame: rect)
        btn.setTitle("X", for: .normal)
        btn.setTitleColor(UIColor.blue.withAlphaComponent(0.8), for: .normal)
        return btn
    }()
    
    @objc func dismissButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var imageView: UIImageView?
    
    override func loadView() {
        super.loadView()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        delegate = self
        
        dismissButton.addTarget(
            self,
            action: #selector(dismissButtonAction(_:)),
            for: .touchUpInside)
        
        view.addSubview(dismissButton)
        dismissButton.bringSubviewToFront(containerScrollView)
        
        imageView = UIImageView(image: UIImage(named: "swiss.jpg"))
        if let imageView = imageView {
            headerView.addSubview(imageView)
            imageView.frame = CGRect(x: 0, y: 0,
                                     width: UIScreen.mainWidth, height: appearence.headerHeight)
        }
    }
    
    required init() {
        super.init()
        // 1
        let childViewController1 = ChildTableViewController()
        childViewController1.title = "First Tab"
        childViewController1.delegate = self

        let childViewController2 = ChildTableViewController()
        childViewController2.title = "Second Tab"
        childViewController2.delegate = self

        let childViewController3 = ChildTableViewController()
        childViewController3.title = "Third Tab"
        childViewController3.delegate = self

        let childViewController4 = OrdinaryViewController()
        childViewController4.title = "Fourth Tab"

        // 2
        viewContorllers = [childViewController1, childViewController2, childViewController3, childViewController4]
        
        // 3
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

extension DemoViewController: CaseContainerDelegate {
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        scrollViewWillBeginDragging scrollView: UIScrollView) {
        print("""
            
            \(#function)
            caseContainerViewController: \(caseContainerViewController)
            scrollViewWillBeginDragging: \(scrollView)
            
            """)
    }
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        progress: CGFloat,
        index: Int,
        scrollViewDidScroll scrollView: UIScrollView) {
        print("""
            
            \(#function)
            caseContainerViewController: \(caseContainerViewController)
            progress: \(progress)
            index: \(index)
            scrollView:\(scrollView)
            
            """)
    }
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDragging scrollView: UIScrollView) {
        print("""
            
            /\(#function)
            caseContainerViewController: \(caseContainerViewController)
            index: \(index)
            scrollView:\(scrollView)
            
            """)
    }
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        index: Int,
        scrollViewDidEndDecelerating scrollView: UIScrollView) {
        print("""
            
            \(#function)
            caseContainerViewController: \(caseContainerViewController)
            scrollView:\(scrollView)
            
            """)
        
    }
    func caseContainer(
        caseContainerViewController: CaseContainerViewController,
        didSelectTabButton tabButton: TabButton,
        prevIndex: Int,
        index: Int) {
        print("""
            
            \(#function)
            caseContainerViewController: \(caseContainerViewController)
            didSelectTabButton: \(tabButton)
            prevIndex: \(prevIndex)
            index: \(index)
            
            """)
    }
    func caseContainer(parallaxHeader progress: CGFloat) {
        print("""
            
            \(#function)
            progress: \(progress)
            
            """)
    }
}

