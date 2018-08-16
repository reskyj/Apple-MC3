//
//  DiscoverImageViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 14/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class DiscoverImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = image

        // Do any additional setup after loading the view.
    }

    

}
