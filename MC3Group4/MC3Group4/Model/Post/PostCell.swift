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
    
    @IBOutlet weak var unseenIndicatorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillCell(schoolName: String, about: String){
        self.schoolNameLabel.text = schoolName
        self.aboutLabel.text = about
    }
    
    func fillThumbnail(thumbnail: UIImage){
        self.thumbnailImage.image = thumbnail
    }
    
    func fillLocation(desc: String){
        self.locationLabel.text = desc
    }
    
    func setUnseenIcon(isSeen: Bool){
        self.unseenIndicatorImage.isHidden = isSeen
    }

}
