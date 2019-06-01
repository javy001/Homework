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
        
        let pendingViewController = PendingViewController()
        let pendingNavigationController = UINavigationController(rootViewController: pendingViewController)
        
        pendingViewController.tabBarItem.image = UIImage(named: "list")
//        pendingNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let addViewController = UINavigationController(rootViewController: AddViewController())
        addViewController.tabBarItem.image = UIImage(named: "plus")
        
        
//        let completeViewController = CompleteTableViewController()
//        let completedNavigationController = UINavigationController(rootViewController: completeViewController)
//        completedNavigationController.tabBarItem.image = UIImage(named: "clock")
        
        let schoolClassTableViewController = ViewClassTableViewController()
        let schooClassNavigationController = UINavigationController(rootViewController: schoolClassTableViewController)
        schooClassNavigationController.tabBarItem.image = UIImage(named: "class")
        
        
        viewControllers = [pendingNavigationController, addViewController, schooClassNavigationController]
        
        for controller in viewControllers! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }


}

