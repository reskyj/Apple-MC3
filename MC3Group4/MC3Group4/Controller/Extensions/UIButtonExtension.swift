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
        self.backgroundColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    func buttonDesignTwo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1).cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.init(red: 100/255, green: 171/255, blue: 255/255, alpha: 1), for: .normal)
    }
}
