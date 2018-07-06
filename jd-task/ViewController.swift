//
//  ViewController.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-06.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let api = APIController(baseURL: URL(string: "http://www.poznan.pl")!)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.execute(StationsQuery(), success: { (output) in
            print(output)
        }) { (failure) in
            print(failure)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

