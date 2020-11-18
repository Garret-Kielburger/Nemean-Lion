//
//  AppDelegate.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import UIKit
import Material
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var screens = [ScreenDataObject]()
    var nav_id = NemeanDatabase.instance.getNavigationId()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Initialize the window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //MARK: Make calls to API prior to running the rest of the bollocks:
        

        
        let apiURL = URL(string: "")
        
        //let task = URLSession.shared.dataTask(with: apiURL!) {(data, response, error) in
        URLSession.shared.dataTask(with: apiURL!) {(data, response, error) in
            
            do {
                let data = data
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                    for item in json {
                        print(item)
                        
                        
                        
                    }
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
            //print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            

        }.resume()
    
        
        
        screens = NemeanDatabase.instance.getAllScreens()
        
        //let tabNav = UITabBarController()
        // let tabNav = TabNavViewController()
        //let swipeNav = UIPageViewController()
       // let swipeNav = PageSwipeViewController()
        
        // Allocate memory for an instance of the 'MainViewController' class
        
        
        // TODO: set up as mainViewController from first screen via screen_orders
        let mainViewController = MainViewController(screen_uuid: "uuid123")
        let navDrawerRootViewController = NavDrawerRootViewController(screen_uuid: "uuid123")
        //let testViewController = MainViewController(screen_uuid: "Swipe Nav Test")
        mainViewController.view.backgroundColor = UIColor.white
        
        
        print("Navigation Id: \(nav_id)")
        //nav_id = 1
        switch nav_id {
        case 1:
            /*
             Tab Navigation
             */
            print("Case: Tab Navigation")
            
//            var tabViewControllers = [UIViewController]()
//            for screen in screens {
//                tabViewControllers.append(MainViewController(screen_uuid: screen.uuid))
//            }
            let tabView = TabNavViewController()
//            view.viewControllers = tabViewControllers
            //tabNav.viewControllers = tabViewControllers
            
            //let appToolbarController = RootAppToolbarController(rootViewController: view)

            window!.rootViewController = tabView

        case 2:
            /*
             Swipe Navigation
             */
            print("Case: Swipe Navigation")
//            var swipeViewControllers = [UIViewController]()
//            
//            for screen in screens {
//                swipeViewControllers.append(MainViewController(screen_uuid: screen.uuid))
//            }
//            
//            swipeNav.setViewControllers(swipeViewControllers, direction: .forward, animated: false, completion: {done in})
            let swipeNav = PageSwipeViewController()

            let appToolbarController = RootAppToolbarController(rootViewController: swipeNav)
            
            window!.rootViewController = appToolbarController
            //window!.rootViewController = UINavigationController(rootViewController: swipeNav)
            
        case 3:
            /*
            Drawer Navigation
            */
            print("Case: Drawer Navigation")
            let leftViewController = NavigationDrawerTableViewController()
            let appToolbarController = AppToolbarController(rootViewController: navDrawerRootViewController)
            
            window!.rootViewController = NavigationDrawerController(rootViewController: appToolbarController, leftViewController: leftViewController)
            
            break
        default:
            break
        }
        
        // Make the window visible
        window!.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive called")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground called")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationDidEnterForeground called")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive called")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("applicationWillTerminate called")
    }


}

