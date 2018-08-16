////
////  DiscoverImagePageViewController.swift
////  MC3Group4
////
////  Created by Resky Javieri on 14/08/18.
////  Copyright © 2018 Resky Javieri. All rights reserved.
////
//
//import UIKit
//
//class DiscoverImagePageViewController: UIPageViewController {
//
//    var images: [UIImage]?
//
//    struct Storyboard {
//        static let DiscoverImageViewController = "DiscoverImageViewController"
//    }
//
//    lazy var viewControllers: [UIViewController] = {
//
//        let storyboard = UIStoryboard(name: "Discover", bundle: nil)
//        var controllers = [UIViewController]()
//
//        if let images = self.images {
//            for image in images {
//                let discoverImageViewController = storyboard.instantiateViewController(withIdentifier: Storyboard.DiscoverImageViewController)
//                controllers.append(discoverImageViewController)
//
//            }
//
//        }
//
//        return controllers
//
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        UIScrollViewContentInsetAdjustmentBehavior = false
//        dataSource = self
//        //delegate = self
//
//        self.turnToPage(index: 0)
//    }
//
//    func turnToPage(index: Int) {
//
//        let controller = controllers[index]
//        var direction = UIPageViewControllerNavigationDirection.forward
//        
//        if let currentVC = viewControllers?.first {
//            let currentIndex = controllers.index(of: currentVC)!
//
//            if currentIndex > index {
//                direction = .reverse
//            }
//
//        }
//        self.configureDisplay(viewController: controller)
//
//
//        setViewControllers([controller], direction: direction, animated: true, completion: nil)
//    }
//
//    func configureDisplaying (viewController: UIViewController) {
//        for (index, vc) in controllers.enumerated() {
//            if viewController === vc {
//                if let discoverImageVC = viewController as? DiscoverImageViewController {
//                    discoverImageVC.image = self.image? [index]
//
//                }
//            }
//        }
//    }
//
//
//}
//
//extension DiscoverImagePageViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        if let index = controllers.index(of: viewController) {
//            if index > 0 {
//                return controllers [index - 1]
//
//            }
//        }
//        return controllers.last
//
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let index = controllers.index(of: viewController) {
//            if index < controllers.count - 1 {
//                return controllers[index + 1]
//            }
//        }
//
//        return controllers.first
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
