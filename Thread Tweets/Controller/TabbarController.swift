//
//  TabbarViewController.swift
//  Thread Tweets
//
//  Created by Malcolm Kumwenda on 2017/07/23.
//  Copyright © 2017 mDevSA. All rights reserved.
//

import UIKit
import SwiftIcons
import ChameleonFramework
import RevealingSplashView

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splashScreen(){
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "logo"),iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor.white)

        self.view.addSubview(revealingSplashView)
        self.setupTabs()
        revealingSplashView.duration = 0.9
        revealingSplashView.animationType = .squeezeAndZoomOut
        revealingSplashView.startAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        splashScreen()
    }
    
    func setupTabs(){
        let tabOne = HomeVC()
        let tabOneBarItem = UITabBarItem(title: nil, image: UIImage.init(icon: .ionicons(.iosBolt), size: CGSize(width: 50, height: 50)) , selectedImage: UIImage.init(icon: .ionicons(.iosBolt), size: CGSize(width: 50, height: 50)))
        tabOne.tabBarItem = tabOneBarItem
        tabOne.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: -16, bottom: -6, right: 16)
        
        let tabTwo = FavVC()
        let tabTwoBarItem = UITabBarItem(title: nil, image: UIImage.init(icon: .ionicons(.bookmark), size: CGSize(width: 50, height: 50)) , selectedImage: UIImage.init(icon: .ionicons(.bookmark), size: CGSize(width: 50, height: 50)))
        tabTwo.tabBarItem = tabTwoBarItem
        tabTwo.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let tabThree = ProfileVC()
        let tabThreeBarItem = UITabBarItem(title: nil, image: UIImage.init(icon: .ionicons(.person), size: CGSize(width: 50, height: 50)) , selectedImage: UIImage.init(icon: .ionicons(.person), size: CGSize(width: 50, height: 50)))
        tabThree.tabBarItem = tabThreeBarItem
        tabThree.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 16, bottom: -6, right: -16)
        
        tabBar.tintColor = UIColor(hexString: "#3498db")
        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = UIColor.lightGray
        viewControllers = [tabOne, tabTwo, tabThree]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
}

