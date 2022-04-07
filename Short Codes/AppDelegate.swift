//
//  AppDelegate.swift
//  Short Codes
//
//  Created by Pulkit Vora on 07/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    func read_Localizable(_ title:String)->String{
            
        let bpath = Bundle.main.path(forResource: "en", ofType: "lproj")! as String
        let bundle = Bundle(path: bpath as String)
        return NSLocalizedString(title, bundle: bundle!, comment: "")
    }


}

