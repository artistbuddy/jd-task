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
        showAllStations()
    }
    
    private func showAllStations() {
        let p = StationsDataProvider(apiControler: Session.api)
        let c = StationsCollectionController(dataSource: p)
        let vm  = StationsViewModel(controller: c, dataProvider: p)
        let vc = StationsViewController(viewModel: vm)
        
        self.navigationController.setViewControllers([vc], animated: false)        
    }
}
