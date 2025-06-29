import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Load the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the initial view controller (ViewController from Main.storyboard)
        if let viewController = storyboard.instantiateInitialViewController() {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        } else {
            print("Error: Failed to load initial view controller from Main.storyboard")
        }
        
        return true
    }
}