//
//  RoundedImage.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
        //        self.layer.borderWidth = 0
        //        self.layer.borderColor = UIColor.blackColor().CGColor
        
        layer.shadowColor = COLOR_GRAY_DARKER.colorWithAlphaComponent(0.8).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
    
    
}