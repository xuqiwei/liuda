//
//  AppDelegate.swift
//  liuda
//
//  Created by 徐其威 on 2019/5/27.
//  Copyright © 2019 徐其威. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 应用程序启动 01
        print("程序-01")
        
        // 1、创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        window?.rootViewController = LLTabBarController()
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        // 当应用程序即将从活动状态转移到非活动状态时发送。这可以发生在某些类型的临时中断（例如来电或SMS消息）或当用户退出应用程序并开始转换到后台状态时。
        // 使用此方法暂停正在进行的任务，禁用定时器，并使图形呈现回调无效。游戏应该用这个方法暂停游戏。 03
        
        print("程序-03")
        networkStopMonitoring()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        // 使用此方法释放共享资源、保存用户数据、使定时器无效，并存储足够的应用程序状态信息，以便在以后终止应用程序时将应用程序恢复到当前状态
        // 如果您的应用程序支持后台执行，则该方法被调用而不是Apple将终止：当用户退出时。 04
        
        print("程序-04")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        // 作为从后台到活动状态的转换的一部分调用；在这里可以撤消在进入后台时所做的许多更改 11
        
        print("程序-11")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        // 重新启动在应用程序处于非活动状态时暂停（或尚未启动）的任何任务 02
        
        print("程序-02")
        networkStartMonitoring()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // 当应用程序即将终止时调用 05
    }


}

