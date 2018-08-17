//
//  OnBoardingViewController.swift
//  MC3Group4
//
//  Created by Resky Javieri on 17/08/18.
//  Copyright © 2018 Resky Javieri. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {

  
    @IBOutlet weak var onBoardingScrollView: UIScrollView!
    @IBOutlet weak var onBoardingPageControl: UIPageControl!
    
    var onBoardingImages = [UIImage]()
    var nextButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onBoardingScrollView.delegate = self

        onBoardingImages = [#imageLiteral(resourceName: "Onboarding-6"), #imageLiteral(resourceName: "Onboarding-5"), #imageLiteral(resourceName: "Onboarding-4")]
        
        //Set attributes ScrollView
        onBoardingScrollView.contentSize.width = self.view.frame.width * CGFloat(onBoardingImages.count)
        onBoardingScrollView.frame.size = self.view.frame.size
        onBoardingScrollView.isPagingEnabled = true
        onBoardingScrollView.showsHorizontalScrollIndicator = false
        
        //Create button
        let nextButtonWidth: CGFloat = 200.0
        let nextButtonHeight: CGFloat = 50.0
        
        nextButton = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - (nextButtonWidth/2), y: self.view.frame.height, width: nextButtonWidth, height: nextButtonHeight))
        nextButton.buttonDesignOne()
    
        nextButton.setTitle("Lanjutkan", for: .normal)
        nextButton.isUserInteractionEnabled = true
        
        
//        nextButton.addTarget(self, action: #selector(OnBoardingViewController.showApp(sender:)), for: .touchUpInside)
        
        self.view.addSubview(nextButton)
        self.view.bringSubview(toFront: nextButton)
        
        
        for n in 0..<onBoardingImages.count {
            let onBoardingImageView = UIImageView()
            onBoardingImageView.image = onBoardingImages[n]
            let position = self.view.frame.width * CGFloat(n)
            
            onBoardingImageView.frame = CGRect(x: position, y: 0, width: onBoardingScrollView.frame.width, height: onBoardingScrollView.frame.height)
            onBoardingImageView.contentMode = .scaleAspectFit

            onBoardingScrollView.addSubview(onBoardingImageView)
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = onBoardingScrollView.contentOffset.x / onBoardingScrollView.frame.width
        onBoardingPageControl.currentPage = Int(page)
        
        if page == 2 {
            UIView.animate(withDuration: 0.5, animations: {self.nextButton.frame.origin.y = 680.0})
        } else if page == 1 {
            UIView.animate(withDuration: 0.5, animations: {self.nextButton.frame.origin.y = 850.0})
        } else if page == 0 {
            UIView.animate(withDuration: 0.5, animations: {self.nextButton.frame.origin.y = 850.0})
        }
    }
    
    @objc func showApp(sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "DiscoverID")
        present(vc, animated: true, completion: nil)
    }
}
