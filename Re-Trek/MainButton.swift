//
//  MainButton.swift
//  Re-Trek
//
//  Created by Austin Wood on 2016-05-22.
//  Copyright © 2016 Austin Wood. All rights reserved.
//

import UIKit

class MainButton: UIButton {
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
        
        //self.layer.borderWidth = 10
        //self.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.alpha = 0.6
        
        //        layer.shadowColor = COLOR_GRAY_DARKER.colorWithAlphaComponent(0.8).CGColor
        //        layer.shadowOpacity = 0.8
        //        layer.shadowRadius = 30.0
        //        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if self.state == .Highlighted {
            self.highlighted = false
        }
        
        self.alpha = 1.0
        NSNotificationCenter.defaultCenter().postNotificationName("flagDown", object: nil)
        
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.alpha = 0.6
        NSNotificationCenter.defaultCenter().postNotificationName("flagUp", object: nil)
        
    }
    
    
    
}