import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        firebaseConfig()
        
        let viewController = HomeController()

        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = viewController
        window?.rootViewController = SwipePhotosController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        window?.makeKeyAndVisible()
        return true
    }
    
    private func firebaseConfig() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}
