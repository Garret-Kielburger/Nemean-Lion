//
//  TabNavViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-26.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class TabNavViewController : UITabBarController {
    
    var screens = [ScreenDataObject]()
    var screen_name : String = ""
    var tabViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TabNavViewController viewDidLoad()")
        
        screens.removeAll()
        screens = NemeanDatabase.instance.getAllScreens()
        
        for screen in screens {
            tabViewControllers.append(MainViewController(screen_uuid: screen.uuid))
        }
        self.viewControllers = tabViewControllers
        self.viewControllers = tabViewControllers.map { UINavigationController(rootViewController: $0)}
        
        prepareToolbar()
        
    }
    
}
extension TabNavViewController {
    fileprivate func prepareToolbar() {
        print("preparing TabNavViewController toolbar title. tabBarItem title: \(self.tabBarItem.title)")
        //print("preparing TabNavViewController toolbar title. navigationItem title: \(self.navigationItem.title)")
        
        guard let tc = toolbarController else {
            print("No ToolbarController")
            return
        }
        
        tc.toolbar.title = self.tabBarItem.title
        
    }
}
