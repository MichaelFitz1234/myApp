//
//  myTabBarController.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/27/20.
//

import UIKit
class myTabBarController: UITabBarController{  
    override func viewDidLoad() {
        super.viewDidLoad()
        let myImage = UIImage(systemName: "message")
        let myImage1 = UIImage(systemName: "person.fill")
        let myImage2 = UIImage(systemName: "map.fill")
        view.backgroundColor = .white
        let firstViewController = homePage()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let secondViewController = InAppMessaging()
        secondViewController.tabBarItem = UITabBarItem(title: "Messages", image: myImage, tag: 1)
        let thirdViewController = SocialPage()
        thirdViewController.tabBarItem =  UITabBarItem(title: "Social", image: myImage1, tag: 2)
        let FourthViewController = MapsController()
        FourthViewController.tabBarItem =  UITabBarItem(title: "Challenges", image: myImage2, tag: 3)
        let tabBarList = [firstViewController, secondViewController,thirdViewController,FourthViewController]
        viewControllers = tabBarList
        }
}
