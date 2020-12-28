//
//  myTabBarController.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/27/20.
//

import UIKit

class myTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let firstViewController = homePage()
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = InAppMessaging()

        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        let thirdViewController = SocialPage()
        thirdViewController.tabBarItem =  UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let tabBarList = [firstViewController, secondViewController,thirdViewController]
        viewControllers = tabBarList
    }
}
