//
//  UITextField.swift
//  MC3Group4
//
//  Created by Resky Javieri on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        self.layer.borderColor = UIColor(white: 213/255, alpha: 1).cgColor
        //        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 0, dy: 8)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
