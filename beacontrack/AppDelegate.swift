//
//  AppDelegate.swift
//  beacontrack
//
//  Created by vivek vivek on 09/01/16.
//  Copyright (c) 2016 inkoop.in. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    
    let beaconManager = ESTBeaconManager()
    let category = "Office"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.beaconManager.delegate = self
        
        self.beaconManager.requestAlwaysAuthorization()
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        self.beaconManager.startMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "33F71DAF-D05D-4AF3-AE70-D6BB2FC271A1")!,
            major: 65502, minor: 43582, identifier: "inkoop office"))
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody = "Office time tracking Started"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        Alamofire.request(.POST, "https://inkoop-beacon-track.herokuapp.com/api/1/tracks.json?api_key=fec7cb71dcabf40b346a", parameters: [ "category": category, "track": "0" ])
    }
    
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody = "Office time tracking Stopped"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        Alamofire.request(.POST, "https://inkoop-beacon-track.herokuapp.com/api/1/tracks.json?api_key=fec7cb71dcabf40b346a", parameters: [ "category": category, "track": "1" ])
    }


}
