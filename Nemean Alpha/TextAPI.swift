//
//  TextAPI.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-10-04.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation

public struct TextAPI : Codable {
    let uuid: String
    let screen_uuid: String
    let purpose: String
    let horizontal_align: Int64
    let vertical_align: Int64
    let content: String
}
