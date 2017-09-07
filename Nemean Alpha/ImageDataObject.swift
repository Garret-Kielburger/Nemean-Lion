//
//  ImageDataObject.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-22.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

class ImageDataObject: DataObjectProtocol {
    
    //let id: Int64?
    var uuid: String
    var screen_uuid: String
    var purpose: String
    var horizontal_align: Int64
    var vertical_align: Int64
    var uri: String
    
//    init(id: Int64) {
//        self.id = id
//        screen_uuid = ""
//        purpose = ""
//        uri = ""
//        horizontal_align = 0
//        vertical_align = 0
//        
//    }
    
    init(uuid: String, screen_uuid: String, purpose: String, horizontal_align: Int64, vertical_align: Int64, uri: String) {
        //self.id = id
        self.uuid = uuid
        self.screen_uuid = screen_uuid
        self.purpose = purpose
        self.horizontal_align = horizontal_align
        self.vertical_align = vertical_align
        self.uri = uri
    }

}

