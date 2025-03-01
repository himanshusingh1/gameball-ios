//
//  AppDelegate.swift
//  GameBallSDK
//
//  Created by Martin Sorsok on 07/23/2019.
//  Copyright (c) 2019 Martin Sorsok. All rights reserved.
//

import UIKit
import Firebase
import Gameball
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var gameballApp: Gameball?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        gameballApp = Gameball(apiKey: "API_KEY_HERE")
        gameballApp?.configureFireBase()
        registerForPushNotifications()
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                UNUserNotificationCenter.current().delegate = self
                Messaging.messaging().delegate = self
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        gameballApp?.recievedDynamicLink(url: url)
    
        return true
    }
}

