//
//  ScreenDataObject.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

class ScreenDataObject:DataObjectProtocol {
 
    let id: Int64?
    var uuid: String
    var name: String
    //var purpose: String
    var order: Int64
    var vertical_align: Int64
    var horizontal_align: Int64
    
    
    init() {
        self.id = 0
        self.uuid = ""
        self.name = ""
        self.order = 0
        self.vertical_align = 0
        self.horizontal_align = 0
        
    }
    
    init(id: Int64) {
        self.id = id
        self.uuid = ""
        self.name = ""
        //purpose = ""
        self.order = 0
        self.vertical_align = 0
        self.horizontal_align = 0

    }
    
    //init(id: Int64, name: String, purpose: String, uuid: String, order: Int64) {
    
    init(id: Int64, uuid: String, name: String, order: Int64) {
        self.id = id
        self.uuid = uuid
        self.name = name
        //self.purpose = purpose
       
        self.order = order
        self.vertical_align = 0
        self.horizontal_align = 0
    }

    init(uuid: String, name: String, order: Int64) {
        self.id = 2
        self.uuid = uuid
        self.name = name
        //self.purpose = purpose
        
        self.order = order
        self.vertical_align = 0
        self.horizontal_align = 0
    }
    
}
