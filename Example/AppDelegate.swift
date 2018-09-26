//
//  AppDelegate.swift
//  Example
//
//  Created by minjuniMac on 26/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
import CaseContainer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //        window?.rootViewController = CaseContainerViewController(vcs)
        let tb = UITabBarController(nibName: nil, bundle: nil)
        let vc1 = UINavigationController(rootViewController: DemoViewController())
        let vc2 = UINavigationController(rootViewController: DemoViewController())
        let vc3 = UINavigationController(rootViewController: DemoViewController())
        tb.viewControllers = [vc1, vc2, vc3]
        
        
        window?.rootViewController =  tb//DemoViewController()//tb //DemoViewController() //tb
        window?.makeKeyAndVisible()
        return true
    }
}
extension UIScreen {
    static var mainBounds: CGRect { return UIScreen.main.bounds }
    static var mainWidth: CGFloat { return UIScreen.main.bounds.width }
    static var mainHeight: CGFloat { return UIScreen.main.bounds.height }
    static var mainSize: CGSize { return UIScreen.main.bounds.size }
}


