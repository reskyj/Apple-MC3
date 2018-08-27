//
//  imagesCollectionCell.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 24/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class imagesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView!
    
    func setCell(image: UIImage){
        self.imageCollection.image = image
    }
}
