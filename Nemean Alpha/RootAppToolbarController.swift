//
//  RootAppToolbarController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-26.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class RootAppToolbarController: ToolbarController {
    
    override func prepare() {
        super.prepare()
        prepareStatusBar()
        prepareToolbar()
    }
}


extension RootAppToolbarController {
    
    fileprivate func prepareStatusBar() {
        statusBarStyle = .lightContent
        
        // Access the statusBar.
        //        statusBar.backgroundColor = Color.green.base
    }
    
    fileprivate func prepareToolbar() {
        
        //toolbar.rightViews = [switchControl, moreButton]
    }
}

