//
//  OnBoardViewController.swift
//  MC3Group4
//
//  Created by Steven Muliamin on 20/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit
import paper_onboarding

class OnBoardViewController: UIViewController, PaperOnboardingDelegate, PaperOnboardingDataSource {

    @IBOutlet weak var myOnBoardView: OnBoardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func onboardingItemsCount() -> Int
    {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Onboarding-1"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.yellow,
                               titleColor: UIColor.blue,
                               descriptionColor: UIColor.red,
                               titleFont: titleFont,
                               descriptionFont: titleFont),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Onboarding-1"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.green,
                               titleColor: UIColor.blue,
                               descriptionColor: UIColor.red,
                               titleFont: titleFont,
                               descriptionFont: titleFont),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Discover-1"),
                               title: "title",
                               description: "description",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.gray,
                               titleColor: UIColor.blue,
                               descriptionColor: UIColor.red,
                               titleFont: titleFont,
                               descriptionFont: titleFont)
            ][index]
    }
    
    func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {
        print("lollllllll")
        item.titleLabel?.backgroundColor = UIColor.red
        item.descriptionLabel?.backgroundColor = UIColor.red
            item.imageView = UIImageView(image: #imageLiteral(resourceName: "Onboarding-6"))
    }

}
