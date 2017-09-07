//
//  ViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var screens = [ScreenDataObject]()
    private var screen_data = [DataObjectProtocol]()
    private var texts = [TextfieldDataObject]()
    
    var shouldUpdateConstraints: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //screens = NemeanDatabase.instance.getAllScreens()
        print("View: \n \(view) \n")
        print("View Superview: \(view.superview) \n")
    
        
        screen_data = NemeanDatabase.instance.getScreenDataByUuid(given_screen_uuid: "uuid123")
       
        for screen_datum in screen_data {
            
            switch String(describing: screen_datum) {
                
            case "Nemean_Alpha.TextfieldDataObject":
                print("Case: TextfieldDataObject")
                
                var tdo = screen_datum as! TextfieldDataObject
                
                 var textView: UITextField! {
                    let view1 = UITextField()
                    view1.translatesAutoresizingMaskIntoConstraints = false
                    view1.borderStyle = .roundedRect
                    view1.textAlignment = .center
                    view1.text = tdo.content
                    
                    return view1
                }
                
                view.addSubview(textView)
                
                //NSLayoutConstraint(item: textView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
              
                
//                print("view superview:")
//print(view.superview)
//                
//                print("textView.superview:")
//print(textView.superview)
                
                
            case "Nemean_Alpha.ImageDataObject":
                print("Case: ImageDataObject")
                
                
            case "Nemean_Alpha.ScreenDataObject":
                print("Case: ScreenDataObject")
                
                
            default:
                print("Oops, nothing found!")
            }
            
           // print(String(describing: screen_datum))
            
        }
        print("View: \n \(view) \n")
        print("View Superview: \(view.superview) \n")
        
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

