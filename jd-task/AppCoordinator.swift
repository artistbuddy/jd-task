//
//  AppCoordinator.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-07.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    
    private var rootViewController: UIViewController {
        return self.navigationController
    }
    private lazy var navigationController: UINavigationController = {
        let controller = UINavigationController()
        
        return controller
    }()
    
    init(window: UIWindow) {
        self.window = window
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let red = UIViewController()
        red.view.backgroundColor = UIColor.red
        
        self.navigationController.setViewControllers([red], animated: false)
    }
}
