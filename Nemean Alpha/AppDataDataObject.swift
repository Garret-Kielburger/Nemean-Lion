//
//  AppDataDataObject.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

class AppDataDataObject {
    
    let id: Int64?
    var app_name: String
    var navigation_id: Int64
    
    init(id: Int64) {
        self.id = id
        app_name = ""
        navigation_id = 0
    }
    
    init(id: Int64, app_name: String, navigation_id: Int64) {
        self.id = id
        self.app_name = app_name
        self.navigation_id = navigation_id
    }
    
}

