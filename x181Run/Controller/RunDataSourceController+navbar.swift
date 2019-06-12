//
//  RunDataSourceController+navbar.swift
//  x181Run
//
//  Created by Peter Forward on 6/1/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

extension RunDatasourceController {
    
    func setupNavigationBarItems() {
        
        setupRightNavItems()
        setupLeftNavItems()
        setupRemainingNavItems()
        
    }
    
    private func setupRemainingNavItems() {
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "YellowRunnerIcon"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    private func setupLeftNavItems() {
        
        let addRunButton = UIButton(type: .system)
        addRunButton.setImage(#imageLiteral(resourceName: "addIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        addRunButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        addRunButton.addTarget(self, action: #selector(addRunButtonTapped), for: .touchUpInside)
        
        let logoutButton = UIButton(type: .system)
        logoutButton.setImage(#imageLiteral(resourceName: "logoutIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        logoutButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: addRunButton), UIBarButtonItem(customView: logoutButton)]
    }
    @objc private func addRunButtonTapped() {
        print("addRunButtonTapped")
        
        let runDetailController = RunDetailController()
        runDetailController.myRunMode = .Create
        present(runDetailController, animated: true, completion: nil)
    }
    
    @objc private func logoutButtonTapped() {
        print("logoutButtonTapped")
        
        //UserDefaults.standard.setIsLoggedIn(value: false)
        
        MyFireLoginService.sharedInstance.logout(vc: self)
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
    
    private func setupRightNavItems() {
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        //searchButton.tag = 1
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        let userInfoButton = UIButton(type: .system)
        userInfoButton.setImage(#imageLiteral(resourceName: "userInfo").withRenderingMode(.alwaysOriginal), for: .normal)
        userInfoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        //userInfoButton.tag = 2
        userInfoButton.addTarget(self, action: #selector(userInfoButtonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchButton), UIBarButtonItem(customView: userInfoButton)]
        
    }
    @objc private func searchButtonTapped(sender: UIButton) {
        print("searchButtonTapped",sender.tag)
    }
    
    @objc private func userInfoButtonTapped(sender: UIButton) {
        print("userInfoButtonTapped",sender.tag)
    }
}
