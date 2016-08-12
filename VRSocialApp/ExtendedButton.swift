//
//  ExtendedButton.swift
//  VRSocialApp
//
//  Created by Volodymyr Romanov on 8/12/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class ExtendedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: COLOR_SHADOW, green: COLOR_SHADOW, blue: COLOR_SHADOW, alpha: 0.8).cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
        layer.cornerRadius = 10
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
