//
//  AppDelegate.swift
//  KnowledgeArrangement
//
//  Created by 无名 on 2019/3/6.
//  Copyright © 2019 ProgrammerHome. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift
import SHFullscreenPopGestureSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Command.globalStyleModification()
        self.window = UIWindow()
        self.window?.makeKey()
        IQKeyboardManager.shared.enable = true
        let base_VC = First_VC()
        let base_nav = TYNavigationController.init(rootViewController: base_VC)
        self.window?.rootViewController = base_nav
        
        // 刷新率
        let fps_lab = WYLFPSLabel()
        
        self.window?.rootViewController?.view.addSubview(fps_lab)
        self.window?.rootViewController?.view.bringSubviewToFront(fps_lab)
        fps_lab.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(30)
        }
        configRealm()
        configBugly()
        // 启用
//        SHFullscreenPopGesture.configure()
        return true
    }
    
    // config  数据库realm
    func configRealm() {
        //realm版本控制
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
        }, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
    }
    
    func configBugly() {
//        Bugly.start(withAppId: "514ed79021")
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

