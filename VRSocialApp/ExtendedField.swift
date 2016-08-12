//
//  ExtendedField.swift
//  VRSocialApp
//
//  Created by Volodymyr Romanov on 8/12/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class ExtendedField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: COLOR_SHADOW, green: COLOR_SHADOW, blue: COLOR_SHADOW, alpha: 0.8).cgColor
        layer.borderWidth = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
