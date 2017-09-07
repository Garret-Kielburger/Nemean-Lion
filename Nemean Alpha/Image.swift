//
//  Image.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-08-28.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class Image: UIImageView {
    
    var url: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
