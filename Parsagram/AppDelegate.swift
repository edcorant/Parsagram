//
//  AppDelegate.swift
//  Parsagram
//
//  Created by Eduardo Antonini on 10/1/20.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let parseConfig = ParseClientConfiguration {
                $0.applicationId = "ADzZFlM1XBadwNedQO8JXpnq5024ezh590IR4CyC"
                $0.clientKey = "kiO3Lpgzk138OrAwRnXsgGEvjlotHcxMYKJYhLGX"
                $0.server = "https://parseapi.back4app.com"
            }
            
        Parse.initialize(with: parseConfig)
        
        if PFUser.current() != nil {
            
            let main = UIStoryboard(name: "Main", bundle: nil)
            let feed_navigator = main.instantiateViewController(identifier: "Feed_Navigator")
            
            window?.rootViewController = feed_navigator
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

