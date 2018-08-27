//
//  UITextField.swift
//  MC3Group4
//
//  Created by Resky Javieri on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
//class DesignTextField: UITextField {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        //        self.layer.borderColor = UIColor(white: 213/255, alpha: 1).cgColor
//        //        self.layer.borderWidth = 1
//        self.layer.shadowColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1).cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
//
//    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 0, dy: 8)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return textRect(forBounds: bounds)
//    }
//}


@IBDesignable
class DesignTextFieldExtension: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1).cgColor
        self.layer.cornerRadius = 15
        
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 25, height: 25))
            imageView.image = image
            imageView.tintColor = tintColor
            
            var width = leftPadding + 23
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 7
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 25))
            view.addSubview(imageView)
            
            leftView = view
            
        } else {
            leftViewMode = .never
        }
        
        
    }
}


