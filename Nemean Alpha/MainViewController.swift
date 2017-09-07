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
    
    private var screen_data = [DataObjectProtocol]()
    var screen: Screen!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //textField.delegate = self
        
        screen = Screen(frame: CGRect.zero)
        
        
    view.addSubview(screen)

    view.setNeedsUpdateConstraints()
    

        
        
    print("\n MainViewController's View: \n \(view) \n")
    print("MainViewController's View Superview: \(view.superview) \n")
    
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
