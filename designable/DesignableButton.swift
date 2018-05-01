//
//  DesugnableButton.swift
//  TechniApp
//
//  Created by Gаггу-Guииz  on 25/04/2018.
//  Copyright © 2018 COFELY_Technibook. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: BounceButton {

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    
    @IBInspectable var cornerRadus: CGFloat = 0{
        didSet {
            self.layer.cornerRadius = cornerRadus
        }
    }
    
}
