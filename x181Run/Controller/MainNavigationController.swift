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
        
        
        //UserDefaults.standard.setLoginEmail(value: "wolfman@hotmail.com")
        //print("**START************")
        //print(UserDefaults.standard.dictionaryRepresentation())
        //print("**END**************")
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
