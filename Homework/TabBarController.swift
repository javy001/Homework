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
        
        let persistantData = PersistantData()
        
        let pendingViewController = PendingViewController()
        pendingViewController.persistantData = persistantData
        let pendingNavigationController = UINavigationController(rootViewController: pendingViewController)
        
        pendingViewController.tabBarItem.image = UIImage(named: "list")
//        pendingNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        let addViewController = AddViewController()
        addViewController.persistantData = persistantData
        let addNavigationController = UINavigationController(rootViewController: addViewController)
        addNavigationController.tabBarItem.image = UIImage(named: "plus")
        
        
//        let completeViewController = CompleteTableViewController()
//        let completedNavigationController = UINavigationController(rootViewController: completeViewController)
//        completedNavigationController.tabBarItem.image = UIImage(named: "clock")
        
        let schoolClassTableViewController = ViewClassTableViewController()
        schoolClassTableViewController.persistantData = persistantData
        let schooClassNavigationController = UINavigationController(rootViewController: schoolClassTableViewController)
        schooClassNavigationController.tabBarItem.image = UIImage(named: "class")
        
        
        viewControllers = [pendingNavigationController, addNavigationController, schooClassNavigationController]
        
        for controller in viewControllers! {
            controller.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        }
    }


}

