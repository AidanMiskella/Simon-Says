//
//  CircularButton.swift
//  Simon Says
//
//  Created by Aidan Miskella on 10/04/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

class CircularButton: UIButton {

    override func awakeFromNib() {
        
        layer.cornerRadius = frame.size.height/2
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool {
        
        didSet{
            
            if isHighlighted {
                alpha = 1.0
            } else {
                alpha = 0.5
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
