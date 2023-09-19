import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  FirebaseApp.configure()
     GMSServices.provideAPIKey("AIzaSyDfy0llb2NK7Dck8AwU7rfa1L6juGKtO3s")
     GeneratedPluginRegistrant.register(with: self)

           FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
              GeneratedPluginRegistrant.register(with: registry)
            }

         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

