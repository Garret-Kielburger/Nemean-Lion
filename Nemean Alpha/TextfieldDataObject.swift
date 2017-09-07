//
//  TextfieldDataObject.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

class TextfieldDataObject: DataObjectProtocol {
    
    //let id: Int64?
    var uuid: String
    var screen_uuid: String
    var purpose: String
    var horizontal_align: Int64
    var vertical_align: Int64
    var content: String
    
//    init(id: Int64) {
//        self.id = id
//        screen_uuid = ""
//        purpose = ""
//        content = ""
//        horizontal_align = 0
//        vertical_align = 0
//        
//    }
    
    init() {
        self.uuid = ""
        self.screen_uuid = ""
        self.purpose = ""
        self.horizontal_align = 0
        self.vertical_align = 0
        self.content = ""
    }
    
    init(uuid: String, screen_uuid: String, purpose: String, horizontal_align: Int64, vertical_align: Int64, content: String) {
        //self.id = id
        self.uuid = uuid
        self.screen_uuid = screen_uuid
        self.purpose = purpose
        self.horizontal_align = horizontal_align
        self.vertical_align = vertical_align
        self.content = content
    }

}
