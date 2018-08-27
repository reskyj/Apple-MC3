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
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.buttonDesignOne()
        
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: self.myOnBoardView,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }

    }

    func onboardingItemsCount() -> Int
    {
        return 3
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
        if (myOnBoardView.currentIndex == 2) {
            continueButton.isHidden = false
        }
        else {
            continueButton.isHidden = true
        }
    }
    
    func onboardingWillTransitonToIndex(_: Int) {
        if (myOnBoardView.currentIndex != 2) {
            continueButton.isHidden = true
        }
        else {
            continueButton.isHidden = false
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "onBoardingToDiscover", sender: self)
    }
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let titleFont = UIFont(name: "Helvetica", size: 16)!
        return [
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Walk-1"),
                               title: "Discover places",
                               description: "Buat setiap perjalanan anda menjadi lebih berarti dengan membantu mereka yang membutuhkan di dalam sepanjang perjalanan anda",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: titleFont,
                               descriptionFont: titleFont),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Sketch-1"),
                               title: "Collect the information needed",
                               description: "Isilah draft anda dengan informasi yang lengkap dan anda membantu komunitas 100 guru memberikan informasi tepat yang mereka butuhkan",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: titleFont,
                               descriptionFont: titleFont),
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Give-1"),
                               title: "Share experience and help them",
                               description: "Sentuh dan sebarkan kebaikan kepada sesama tinggalkan kebaikan untuk mereka yang benar membutuhkan",
                               pageIcon: #imageLiteral(resourceName: "EmptyPic"),
                               color: UIColor.white,
                               titleColor: UIColor.black,
                               descriptionColor: UIColor.black,
                               titleFont: titleFont,
                               descriptionFont: titleFont)
            ][index]
    }
    

    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    }
    

}
