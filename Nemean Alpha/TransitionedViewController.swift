//
//  TransitionedViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-23.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class TransitionedViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.purple.base
        
        prepareToolbar()
    }
}

extension TransitionedViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        tc.toolbar.title = "Transitioned"
        tc.toolbar.detail = "View Controller"
    }
}
