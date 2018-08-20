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
            
            OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "Onboarding-1"),
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
    
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        // add custom background image
//        let tmp: Int = 500
        
        // assume you have an array of uiimages
//        if item.viewWithTag(tmp + 1) == nil {
//            let imgView = UIImageView(image: #imageLiteral(resourceName: "Onboarding-6"))
////            imgView.tag = tmp + 1
//            imgView.contentMode = .scaleToFill
//
//            item.insertSubview(imgView, at: 0)
//
//            // for instance I like to have blur effect on my background images
////            let blurEffect = UIBlurEffect(style: .dark)
////            let blurOverlay = UIVisualEffectView(effect: blurEffect)
////            blurOverlay.alpha = 0.90
////            blurOverlay.frame = view.bounds
////            blurOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
////
////            imgView.addSubview(blurOverlay)
//
//            // I use SnapKit for auyolayout engine
//            // you can use whatever you want
//            // important thing is you must give full screen size as imageview frame size.
////            imgView.snp.remakeConstraints({ (make) in
////                make.size.equalTo(view.bounds.size)
////            })
////
////            blurOverlay.snp.remakeConstraints({ (make) in
////                make.edges.equalToSuperview()
////            })
//            let screenSize: CGRect = UIScreen.main.bounds
//            imgView.frame = CGRect(x: 0, y: (0-(imgView.superview?.frame.origin.y)!), width: screenSize.width, height: screenSize.height)
        
//            imgView.frame.origin.x = 100
//            imgView.frame.origin.y = 100
//        }
    }
    

}
