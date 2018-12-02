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
        btn.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: .normal)
        return btn
    }()
    
    @objc func dismissButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var imageView: UIImageView = {
        let _imageView = UIImageView(frame: CGRect.zero)
        _imageView.contentMode = .scaleAspectFit
        return _imageView
    }()
    
    var mock = MockInformation()
    
    required init() {
        super.init()
        // 1
        let childViewController1 = ChildTableViewController()
        childViewController1.title = "TableView-first"
        childViewController1.delegate = self

        let childViewController2 = ChildCollectionViewContorller(collectionViewLayout: UICollectionViewFlowLayout())
        childViewController2.title = "CollectionView-second"
        childViewController2.delegate = self

        let childViewController3 = ChildTableViewController()
        childViewController3.title = "TableView-third"
        childViewController3.delegate = self
        
        let childViewController4 = ChildCollectionViewContorller(collectionViewLayout: UICollectionViewFlowLayout())
        childViewController4.title = "CollectionView-fourth"
        childViewController4.delegate = self
        
        let childViewController5 = ChildTableViewController()
        childViewController5.title = "TableView-fifth"
        childViewController5.delegate = self

        let childViewController6 = OrdinaryViewController()
        childViewController6.title = "Ordinary-sixth"

        // 2
        viewContorllers = [childViewController1, childViewController2, childViewController3, childViewController4, childViewController5, childViewController6]
    
        // 3
        appearence = Appearance(
            headerViewHegiht: 300, tabScrollViewHeight: 50,
            indicatorColor: .darkGray,
            tabButtonColor: (normal: .gray, highLight: .black))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        dismissButton.addTarget(
            self,
            action: #selector(dismissButtonAction(_:)),
            for: .touchUpInside)
        
        view.addSubview(dismissButton)
        dismissButton.bringSubviewToFront(containerScrollView)
        if let navigationBar = navigationController?.navigationBar {
            dismissButton.frame.origin.y += navigationBar.frame.height
            navigationItem.title = "Navigation Bar"
        }
        setupImageView()
    }
    
    func setupImageView() {
        imageView = UIImageView(image: mock.information[0].image)
        headerView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: headerView.heightAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, constant: 0).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(maintain: [UIViewController], appearence: Appearance) {
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
        imageView.layer.opacity = Float(1 - progress)
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
        imageView.layer.opacity = 1
        imageView.image = mock.information[index].image
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
        imageView.image = mock.information[index].image
    }
    func caseContainer(parallaxHeader progress: CGFloat) {
        print("""
            
            \(#function)
            progress: \(progress)
            
            """)
        imageView.alpha = 1 - progress
    }
}
