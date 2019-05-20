//
//  ViewController.swift
//  Homework
//
//  Created by Javier Quintero on 5/10/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pendingViewController = UINavigationController(rootViewController: PendingViewController())
        
//        let icon = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostViewed, tag: 0)
        pendingViewController.tabBarItem.image = UIImage(named: "list")
        
        let addViewController = UINavigationController(rootViewController: AddViewController())
        addViewController.tabBarItem.image = UIImage(named: "plus")
        
        let completedViewController = UINavigationController(rootViewController: CompletedViewController())
        completedViewController.tabBarItem.image = UIImage(named: "clock")
        
        viewControllers = [pendingViewController, addViewController, completedViewController]
    }


}

