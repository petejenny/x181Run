//
//  LoginController.swift
//  x181Run
//
//  Created by Peter Forward on 6/1/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        navigationItem.title = "Login Controller"
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
//
//        let imageView = UIImageView(image: UIImage(named: "home"))
//        view.addSubview(imageView)
//        _ = imageView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
//    @objc func handleSignOut() {
//        print("sign out")
//        UserDefaults.standard.setIsLoggedIn(value: false)
//
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
//    }
}
