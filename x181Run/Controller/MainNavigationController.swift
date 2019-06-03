//
//  MainNavigationController.swift
//  x181Run
//
//  Created by Peter Forward on 6/3/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
//        let runDatasourceController = RunDatasourceController()
//        viewControllers = [runDatasourceController]
        
        if isLoggedIn() {
            //assume user is logged in
        let runDatasourceController = RunDatasourceController()
        viewControllers = [runDatasourceController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return true
        //return UserDefaults.standard.isLoggedIn()
    }

    @objc func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: {
            //perhaps we'll do something here later
        })
    }
}
