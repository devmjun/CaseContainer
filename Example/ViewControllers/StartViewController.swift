//
//  StartViewController.swift
//  Example
//
//  Created by minjuniMac on 01/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

final class StartViewController: UITableViewController {
    enum Titles: String, CaseIterable {
        case fullScreen
        case withTabBarController
        case withNavigationController
        case both
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Titles.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Titles.allCases[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let string = tableView.cellForRow(at: indexPath)?.textLabel?.text,
            let selectedTitle = Titles(rawValue: string) {
            let demoViewController = DemoViewController()
            switch selectedTitle {
            case .fullScreen:
                show(demoViewController, sender: nil)
                
            case .withTabBarController:
                let tabBarViewController = UITabBarController()
                demoViewController.title = "TabBar"
                tabBarViewController.viewControllers = [demoViewController]
                show(tabBarViewController, sender: nil)
                
            case .withNavigationController:
                let naviViewController = UINavigationController(rootViewController: demoViewController)
                naviViewController.navigationBar.isHidden = false
                show(naviViewController, sender: nil)
                
            case.both :
                let tabBarViewController = UITabBarController()
                let childVC = UINavigationController(rootViewController: demoViewController)
                childVC.navigationBar.isHidden = false
                childVC.tabBarItem.title = "TabBar"
                tabBarViewController.viewControllers = [childVC]
                show(tabBarViewController, sender: nil)
            }
        }
    }
}
