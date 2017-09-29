//
//  Screen.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-31.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit

// MIGHT need to extend UIViewController instead of UIView? 
class Screen: UIView {

    var shouldUpdateConstraints: Bool = true
    private var screen_data = [DataObjectProtocol]()
    private var constraintArrayOfViewObjects = [UIView]()
    private var allViewObjects: [String : UIView] = [:]
    
    var screen_uuid: String
    
    override init(frame: CGRect) {
        screen_uuid = ""
        print("screen_uuid in override init: \(screen_uuid) \n")
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, screen_uuid: String) {
        self.init(frame: frame)
        self.screen_uuid = screen_uuid
        print("screen_uuid in convenience init: \(screen_uuid) \n")
        constraintArrayOfViewObjects.removeAll()
        allViewObjects.removeAll()
        screen_data.removeAll()
    
        self.backgroundColor = UIColor.white
        screen_data = NemeanDatabase.instance.getScreenDataByUuid(given_screen_uuid: screen_uuid)
        for screen_datum in screen_data {
            
            switch String(describing: screen_datum) {
                
            case "Nemean_Alpha.TextfieldDataObject":
                print("Case: TextfieldDataObject")
                
                var tdo = screen_datum as! TextfieldDataObject
                
               // var textView: UITextView! {
               // let view1 = UITextField()
                let view1 = UITextView()
                    view1.isScrollEnabled = false
                    view1.translatesAutoresizingMaskIntoConstraints = false
                    view1.textColor = UIColor.blue
                    view1.backgroundColor = UIColor.gray
                    //view1.isSelectable = false
                    //view1.layoutManager.ensureLayout(forCharacterRange: <#T##NSRange#>)
                    //view1.isEditable = false
                    view1.textAlignment = .center
                //view1.text = NSLocalizedString(tdo.content, comment:"")
                    view1.text = tdo.content
               //     return view1
                //}

                print("TextView text: \(view1.text) \n")
                constraintArrayOfViewObjects.append(view1)
                allViewObjects[tdo.uuid] = view1
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
            
                let screenSize: CGRect = UIScreen.main.bounds
                
                let view = UIImageView()
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.frame = CGRect(x: 0, y: 0, width: screenSize.width * 0.5, height: screenSize.height * 0.2)
                var url = URL(string: ido.uri)
                    view.kf.setImage(with: url)
                
                
                allViewObjects[ido.uuid] = view
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
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func updateConstraints() {
        print("UpdateConstraints() Started")
        if (shouldUpdateConstraints){
            
//            List <do>             --> screen_data
//            Map <Uuid, view>      --> allViewObjects
//            <Constraints>
//            
//            Loop list<do>
//            For each do,
//            Do.uuid map view object
//            Do.uuid constraints
//            Apply constraints to do or all at once to <do>
            
            
            // TODO: Get images automatically resizing/shrinking to screen
        
            
            var viewObjectConstraints = [ConstraintDataObject]()
            
            var startSide = NSLayoutAttribute.left
            var endSide = NSLayoutAttribute.right
        
            //print(allViewObjects)
        
            for (uuid, viewObject) in allViewObjects {
                
                //print("Uuid as key in viewObject: \(uuid) \n")
                
                viewObjectConstraints = NemeanDatabase.instance.getAllConstraintsByUuid(given_view_object_uuid: uuid)
                
                //print(viewObjectConstraints)
                
                for constraint in viewObjectConstraints {
                    
                    if (uuid == "a1"){
                        NSLayoutConstraint(
                            item: allViewObjects[uuid],
                            attribute: .topMargin,
                            relatedBy: .equal,
                            toItem: allViewObjects[uuid]?.superview,
                            attribute: .bottom,
                            multiplier: 1.0,
                            constant: 10.0).isActive = true
                        print(allViewObjects[uuid]?.superview)
                        
                    }
                    
                    switch constraint.start_side {
                        case "BOTTOM":
                            startSide = NSLayoutAttribute.bottom
                        case "TOP":
                            startSide = NSLayoutAttribute.top
                        case "START":
                            startSide = NSLayoutAttribute.left
                        case "END":
                            startSide = NSLayoutAttribute.right
                        default:
                            print("Not found!")
                    }
                    
                    switch constraint.end_side{
                        case "BOTTOM":
                            endSide = NSLayoutAttribute.bottom
                        case "TOP":
                            endSide = NSLayoutAttribute.top
                        case "START":
                            endSide = NSLayoutAttribute.left
                        case "END":
                            endSide = NSLayoutAttribute.right
                        default:
                        print("constraint.end_side is not bottom, top, start, or end")
                    }
                    
                    // MARK: Debugging print stuff
                    //print("View Object with Start_Id: \(allViewObjects[uuid]) \n")
                    //print("View Object with End_Id: \(allViewObjects[constraint.end_id]) \n")
                    //print("View Object constraint.end_side: \(constraint.end_side)")
                    
                    NSLayoutConstraint(item: allViewObjects[uuid],
                                       attribute: startSide,
                                       relatedBy: .equal,
                                       toItem: allViewObjects[constraint.end_id],
                                       attribute: endSide,
                                       multiplier: 1,
                                       constant: CGFloat(Float(-constraint.margin))).isActive = true
                }
            }
            
            /*
                    Original Attempt, keeping for reference for now.
             */
            
//            let totalItems = constraintArrayOfViewObjects.count
//            for (index, viewObject) in constraintArrayOfViewObjects.enumerated() {
//                
//                if (index == 0) {
//                    NSLayoutConstraint(
//                        item: constraintArrayOfViewObjects[index],
//                        attribute: .topMargin,
//                        relatedBy: .equal,
//                        toItem: constraintArrayOfViewObjects[index].superview,
//                        attribute: .bottom,
//                        multiplier: 1.0,
//                        constant: -80.0).isActive = true
//                    print(constraintArrayOfViewObjects[index].superview)
//                }
//                
//                if ((index + 1 < totalItems) && (index > 0)) {
//                    NSLayoutConstraint(
//                        item: constraintArrayOfViewObjects[index],
//                        attribute: .bottom,
//                        relatedBy: .equal,
//                        toItem: constraintArrayOfViewObjects[index + 1],
//                        attribute: .top,
//                        multiplier: 1.0,
//                        constant: -8.0)
//                        .isActive = true
//                    
//                    print(index)
//                }
//            }
            
            shouldUpdateConstraints = false
        }
    
        super.updateConstraints()
    }
    
    
}


