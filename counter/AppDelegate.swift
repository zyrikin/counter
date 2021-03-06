//
//  AppDelegate.swift
//  counter
//
//  Created by Nik Zakirin on 07/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerNotifications()
        
        // App language
        ProfileSettings.setAppLanguage(ProfileSettings.appLanguage())
        
        // Theming
        window!.backgroundColor = UIColor.darkBackground
        Theme.appColorScheme = .darkTheme
        
        // Data store
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: Event.className()) { oldObject, newObject in        
                        newObject!["createdAt"] = Date()
                    }
                }
        })
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

fileprivate extension AppDelegate {
    func registerNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Notifications.ApplicationLanguageChanged.rawValue), object: nil, queue: nil) { [unowned self] note in
            self.reload()
        }
    }
    
    func reload() {
        
        guard let nvc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController else { return }
        
        // Transition to content
        let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)

        nvc.topViewController?.view.addSubview(overlayView)
        
        window?.rootViewController = nvc
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve, animations: {
            overlayView.alpha = 0
        }) { finished in
            overlayView.removeFromSuperview()
        }
    }
}

