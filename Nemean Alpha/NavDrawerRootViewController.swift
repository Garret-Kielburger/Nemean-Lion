//
//  NavDrawerRootViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-26.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class NavDrawerRootViewController: UIViewController {
    
    private var screen_data = [DataObjectProtocol]()
    var screen: Screen!
    var screen_uuid: String = ""
    var screen_name: String = ""
    
    
    convenience init(screen_uuid: String){
        self.init()
        self.screen_uuid = screen_uuid
        screen_name = NemeanDatabase.instance.getScreenMetadata(given_screen_uuid: screen_uuid).name
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //textField.delegate = self
        
        prepareToolbar()
        
        screen = Screen(frame: CGRect.zero, screen_uuid: screen_uuid)
        //screen = Screen(frame: CGRect.zero)
        
        view.addSubview(screen)
        
        view.setNeedsUpdateConstraints()
        
        print("\n NavDrawerRootViewController's View: \n \(view) \n")
        print("NavDrawerRootViewController's View Superview: \(view.superview) \n")
        

        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismisses the Keyboard by making the text field resign first responder
        textField.resignFirstResponder()
        
        // returns false. Instead of adding a line break, the text field resigns
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

extension NavDrawerRootViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        print("toolbar update screen_name: \(screen_name)")
        tc.toolbar.title = screen_name
        //tc.toolbar.detail = "View Controller"
    }
}
