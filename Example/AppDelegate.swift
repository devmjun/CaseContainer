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
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let mainWindow = window else {
            fatalError()
        }
        mainWindow.rootViewController = StartViewController(style: .plain)
        mainWindow.makeKeyAndVisible()
        
        return true
    }
}
extension UIScreen {
    static var mainBounds: CGRect { return UIScreen.main.bounds }
    static var mainWidth: CGFloat { return UIScreen.main.bounds.width }
    static var mainHeight: CGFloat { return UIScreen.main.bounds.height }
    static var mainSize: CGSize { return UIScreen.main.bounds.size }
}

extension UIColor {
    static func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
