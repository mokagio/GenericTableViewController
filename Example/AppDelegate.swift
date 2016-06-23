import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)

    let dummy = UIViewController()
    dummy.view.backgroundColor = UIColor.redColor()
    let navigationController = UINavigationController(rootViewController: dummy)

    window?.rootViewController = navigationController

    window?.makeKeyAndVisible()
    return true
  }
}
