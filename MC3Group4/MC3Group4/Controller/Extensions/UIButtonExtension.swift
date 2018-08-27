//
//  extensions.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func buttonDesignOne(){
        self.backgroundColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1)
        self.layer.cornerRadius = 15 //self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func buttonDesignTwo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1).cgColor
        self.layer.cornerRadius = 15 //self.frame.height / 2
        self.setTitleColor(UIColor.init(red: 45/255, green: 122/255, blue: 143/255, alpha: 1), for: .normal)
    }
}
