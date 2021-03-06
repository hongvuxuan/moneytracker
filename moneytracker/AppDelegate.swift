//
//  AppDelegate.swift
//  moneytracker
//
//  Created by Peter Ho on 9/4/18.
//  Copyright © 2018 Peter Ho. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let userDefaults = UserDefaults(suiteName: "group.peterho.moneytracker")!
        let isInitInfo = userDefaults.bool(forKey: "user_info_initialized")
        let now = Date()
        let calendar = Calendar.current
        if isInitInfo == false {
            userDefaults.set(0, forKey: balanceKeyName)
            userDefaults.set(0, forKey: budgetKeyName)
            userDefaults.set(0, forKey: savingKeyName)
            userDefaults.set(0, forKey: spentKeyName)
            userDefaults.set(CalendarHelper.getString(fromDate: now, format: "MM/yyyy"), forKey: monthSpendKeyName)
            userDefaults.set(CalendarHelper.getString(fromDate: now, format: "MM/yyyy"), forKey: savingMonthKeyName)
            userDefaults.set([0, 0, 0, 0, 0], forKey: savingHistoryKeyName)
            userDefaults.set(true, forKey: "user_info_initialized")
        } else {
            if CalendarHelper.compareDateFromString(userDefaults.string(forKey: monthSpendKeyName)!, CalendarHelper.getString(fromDate: now, format: "MM/yyyy")) != .equal {
                userDefaults.set(0, forKey: spentKeyName)
                userDefaults.set(calendar.component(.month, from: now), forKey: monthSpendKeyName)
            }
        }
        
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
        // Saves changes in the application's managed object context before the application terminates.
        DB.save()
    }

    

}

