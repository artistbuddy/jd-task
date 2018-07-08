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
        
        controller.isNavigationBarHidden = false
        controller.navigationBar.isTranslucent = false
        controller.navigationBar.tintColor = UIColor.white
        controller.navigationBar.barTintColor = UIColor.black
    
        controller.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        controller.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        controller.navigationBar.backItem?.title = "" //it doesn't work

        return controller
    }()
    
    init(window: UIWindow) {
        self.window = window
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        if Session.location.shouldRequestAuthorization() {
            Session.location.requestAuthorization()
        }
        
        showAllStations()
    }
    
    private func showAllStations() {
        let p = StationsDataProvider(apiControler: Session.api, locationManager: Session.location)
        let vm = StationsViewModel(dataProvider: p)
        vm.delegate = self
        let vc = StationsViewController(viewModel: vm)
        
        self.navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showStationDetails(_ station: StationInfo) {
        let vc = StationDetailsViewController(station: station)
        
        self.navigationController.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: StationsViewModelDelegate {
    func didSelectStation(_ station: StationInfo) {
        showStationDetails(station)
    }
}
