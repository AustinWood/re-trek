//
//  RoundedButton.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        
        //self.layer.borderWidth = 10
        //self.layer.borderColor = UIColor.whiteColor().CGColor
        
        //self.alpha = 0.6
        
        //        layer.shadowColor = COLOR_GRAY_DARKER.colorWithAlphaComponent(0.8).CGColor
        //        layer.shadowOpacity = 0.8
        //        layer.shadowRadius = 30.0
        //        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
    
}