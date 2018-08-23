//
//  UITextViewExtension.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func textViewDesign() {
        
        self.textColor = UIColor.black
        self.isSelectable = true
        self.isEditable = true
        self.dataDetectorTypes = UIDataDetectorTypes.link
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }
        
}
