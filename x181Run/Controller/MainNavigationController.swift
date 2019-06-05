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
        
        if isLoggedIn() {
            //assume user is logged in
            let runDatasourceController = RunDatasourceController()
            viewControllers = [runDatasourceController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        
        if !UserDefaults.standard.isLoggedIn() {
            return false
        }
            
        guard let email = UserDefaults.standard.getLoginEmail()
        else {
            return false
        }
        guard let password = UserDefaults.standard.getLoginPassword()
            else {
                return false
        }
        
        

        return UserDefaults.standard.isLoggedIn()
    }

//    @objc func showRunDatasourceController() {
//        let runDatasourceController = RunDatasourceController()
//        present(runDatasourceController, animated: true, completion: {
//            //perhaps we'll do something here later
//            print("Completed showing runDatasourceController")
//
//        })
//    }
    
    @objc func showLoginController() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: {
            //perhaps we'll do something here later
            print("Completed login process")
        })
    }
    
    
}
