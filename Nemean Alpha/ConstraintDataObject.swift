//
//  ConstraintDataObject.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-02.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

class ConstraintDataObject {
    
    var screen_uuid: String
    var start_id: String
    var start_side: String
    var end_id: String
    var end_side: String
    var margin: Int
    
    init(){
        screen_uuid = ""
        start_id = ""
        start_side = ""
        end_id = ""
        end_side = ""
        margin = 0
    }
    
    init(screen_uuid: String, start_id: String, start_side: String, end_id: String, end_side: String, margin: Int){
        self.screen_uuid = screen_uuid
        self.start_id = start_id
        self.start_side = start_side
        self.end_id = end_id
        self.end_side = end_side
        self.margin = margin
    }
    
}
