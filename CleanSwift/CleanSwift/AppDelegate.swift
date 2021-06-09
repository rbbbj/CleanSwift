import UIKit
import RealmSwift

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO: remove later, it's just for development
        print("Realm location: ", Realm.Configuration.defaultConfiguration.fileURL!)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Main is the name of storyboard

        window = UIWindow()
        self.window?.rootViewController = storyboard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()

        return true
    }
}
