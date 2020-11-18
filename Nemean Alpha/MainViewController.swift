//
//  MainViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-30.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var screen: Screen!
    var screen_uuid: String = ""
    var screen_name: String = ""
    
    convenience init(screen_uuid: String){
        self.init()
        self.screen_uuid = screen_uuid
        screen_name = NemeanDatabase.instance.getScreenMetadata(given_screen_uuid: screen_uuid).name
        self.title = screen_name
        //self.navigationItem.title = screen_name
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textField.delegate = self
    
        //prepareToolbar()
        
        screen = Screen(frame: CGRect.zero, screen_uuid: screen_uuid)
        //screen = Screen(frame: CGRect.zero)
        
        
    view.addSubview(screen)
    

    view.setNeedsUpdateConstraints()
    

        
        
    //print("\n MainViewController's View: \n \(view) \n")
    //print("MainViewController's View Superview: \(view.superview) \n")
    
}


func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Dismisses the Keyboard by making the text field resign
    // first responder
    textField.resignFirstResponder()
    
    // returns false. Instead of adding a line break, the text
    // field resigns
    return false
    
    
}

override func updateViewConstraints() {
    
    
    
    
    // stuff goes before super.
    super.updateViewConstraints()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}

extension MainViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            print("No ToolbarController in MainViewController")
            return
        }
        print("MainViewController toolbar update screen_name: \(screen_name)")
        tc.toolbar.title = self.title
        //tc.toolbar.detail = "View Controller"
    }
}

