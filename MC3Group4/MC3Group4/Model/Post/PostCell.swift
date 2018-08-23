//
//  DraftCell.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 23/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCell(){
        
    }

}
