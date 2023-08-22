//
//  AppDelegate.swift
//  Interica
//
//  Created by Алексей on 18.10.2022.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        FirebaseApp.configure()
        Messaging.messaging().isAutoInitEnabled = true
        registerForPushNotifications(app: application)
        
        return true
    }
    
    func registerForPushNotifications(app: UIApplication) {
           UNUserNotificationCenter.current().delegate = self
           Messaging.messaging().delegate = self
          

           let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
           UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (authorized, error) in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               if authorized {
                   Auth.sharedInstance().isAuth = true
                   print("authorized")
                   DispatchQueue.main.async {
                     UIApplication.shared.registerForRemoteNotifications()
                   }
               } else {
                   Auth.sharedInstance().isAuth = false
                   print("denied")
               }
           }
           app.registerForRemoteNotifications()
       }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        
        completionHandler(UNNotificationPresentationOptions.alert)
    }

}

extension AppDelegate:MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        Auth.sharedInstance().pushToken = fcmToken ?? ""
   //   deviceToken = fcmToken ?? ""
//      UserDefaults.standard.set(fcmToken ?? "", forKey: "FCMToken")
//      let dataDict: [String: String] = ["token": fcmToken ?? ""]
//      NotificationCenter.default.post(
//        name: Notification.Name("FCMToken"),
//        object: nil,
//        userInfo: dataDict
//      )
       
      
    }

   
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }


}

