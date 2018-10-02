//
//  StartViewController.swift
//  Example
//
//  Created by minjuniMac on 01/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

class StartViewController: UITableViewController {
    enum Titles: String, CaseIterable {
        case fullScreen
        case withTabBarController
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
            switch selectedTitle {
            case .fullScreen:
                let viewController = DemoViewController()
                show(viewController, sender: nil)
            case .withTabBarController:
                let tabBarViewController = UITabBarController()
                let childVC = DemoViewController()
                childVC.title = "TabBar"
                tabBarViewController.viewControllers = [childVC]
                
                show(tabBarViewController, sender: nil)
            }
        }
    }
}
