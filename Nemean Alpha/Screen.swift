//
//  Screen.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-31.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit

class Screen: UIView {

    var shouldUpdateConstraints: Bool = true
    private var screen_data = [DataObjectProtocol]()
    private var constraintArrayOfViewObjects = [UIView]()
    private var allViewObjects: [String : UIView] = [:]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        screen_data = NemeanDatabase.instance.getScreenDataByUuid(given_screen_uuid: "uuid123")
        constraintArrayOfViewObjects.removeAll()
        allViewObjects.removeAll()
        
        for screen_datum in screen_data {
            
            switch String(describing: screen_datum) {
                
            case "Nemean_Alpha.TextfieldDataObject":
                print("Case: TextfieldDataObject")
                
                var tdo = screen_datum as! TextfieldDataObject
                
               // var textView: UITextView! {
                let view1 = UITextField()
                    view1.translatesAutoresizingMaskIntoConstraints = false
                    view1.textColor = UIColor.blue
                    view1.backgroundColor = UIColor.gray
                
                    view1.textAlignment = .center
                    view1.text = tdo.content
               //     return view1
                //}

                constraintArrayOfViewObjects.append(view1)
                self.addSubview(view1)
                
                //NSLayoutConstraint(item: textView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
                
            
//                print("view superview: /n /n /n ")
//                print(self.superview)
//                
//                print("view1 superview: /n")
//                print(view1.superview)
                
                
            case "Nemean_Alpha.ImageDataObject":
                print("Case: ImageDataObject")
                
                var ido = screen_datum as! ImageDataObject
                
                let view = UIImageView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                var url = URL(string: ido.uri)
                    view.kf.setImage(with: url)
                
                constraintArrayOfViewObjects.append(view)
                self.addSubview(view)
                
            case "Nemean_Alpha.ScreenDataObject":
                print("Case: ScreenDataObject")
                
                
            default:
                print("Oops, nothing found!")
            }
        
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if (shouldUpdateConstraints){
            
//            List <do>
//            Map <Uuid, view>
//            <Constraints>
//            
//            Loop list<do>
//            For each do,
//            Do.uuid map view object
//            Do.uuid constraints
//            Apply constraints to do or all at once to <do>
            
            
            
            
            
            
            
            let totalItems = constraintArrayOfViewObjects.count
            for (index, viewObject) in constraintArrayOfViewObjects.enumerated() {
                
                if (index == 0) {
                    NSLayoutConstraint(
                        item: constraintArrayOfViewObjects[index],
                        attribute: .topMargin,
                        relatedBy: .equal,
                        toItem: constraintArrayOfViewObjects[index].superview,
                        attribute: .bottom,
                        multiplier: 1.0,
                        constant: -80.0)
                }
                
                if ((index + 1 < totalItems) && (index > 0)) {
                    NSLayoutConstraint(
                        item: constraintArrayOfViewObjects[index],
                        attribute: .bottom,
                        relatedBy: .equal,
                        toItem: constraintArrayOfViewObjects[index + 1],
                        attribute: .top,
                        multiplier: 1.0,
                        constant: -8.0)
                        .isActive = true
                    
                    print(index)
                }
            }
            
            shouldUpdateConstraints = false
        }
    
        super.updateConstraints()
    }
    
    
}


