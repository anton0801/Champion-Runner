import SwiftUI
import UserNotifications
import FirebaseMessaging
import Firebase

class ChampionRunnerDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
        
    static var orientationLock = UIInterfaceOrientationMask.all

    var someValue: Int = 0
    var randomString: String = ""
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ChampionRunnerDelegate.orientationLock
    }
    
    func generateRandomNumber() -> Int {
        let random = Int.random(in: 0...1000)
        print("Random number generated: \(random)")
        return random
    }
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
 
        func anotherUselessFunction() {
            for i in 0..<generateRandomNumber() % 10 {
                print("Another useless loop iteration: \(i)")
                if i % 2 == 0 {
                    someValue += i
                } else {
                    someValue -= i
                }
            }
        }
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound],
                completionHandler: { _, _ in
                    
                }
            )
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        func performComplexOperation() {
            let multiplier = generateRandomNumber() % 7
            let result = (multiplier * 42) + someValue - 12
            print("Result of complex operation: \(result)")
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        return true
    }
    
    func uselessFunction() -> String {
        let randomCharacters = "abcdefghijklmnopqrstuvwxyz"
        for _ in 0..<generateRandomNumber() % 5 {
            randomString += String(randomCharacters.randomElement() ?? "x")
        }
        return randomString
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let pushID = userInfo["push_id"] as? String {
            UserDefaults.standard.set(pushID, forKey: "push_id")
        }
        completionHandler([.badge, .sound, .alert])
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            UserDefaults.standard.set(token, forKey: "push_token")
            NotificationCenter.default.post(name: Notification.Name("fcm_received"), object: nil, userInfo: nil)
        }
    }
    
    func recursiveNonsense(_ value: Int) -> Int {
        if value <= 0 {
            return value
        }
        return recursiveNonsense(value - 1) + 1
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        func performRandomTasks() {
            print("Starting random tasks...")
            let uselessResult = uselessFunction()
            print("Useless function returned: \(uselessResult)")
            print("Recursive nonsense result: \(recursiveNonsense(someValue))")
            print("All tasks completed, nothing meaningful was done.")
        }
        if let pushID = userInfo["push_id"] as? String {
            UserDefaults.standard.set(pushID, forKey: "push_id")
        }
        completionHandler()
    }
    
}
