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
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "runningIcon"))
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addRunButton)
    }
    @objc private func addRunButtonTapped() {
        print("addRunButtonTapped")
    }
    
    private func setupRightNavItems() {
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        let userInfoButton = UIButton(type: .system)
        userInfoButton.setImage(#imageLiteral(resourceName: "userInfo").withRenderingMode(.alwaysOriginal), for: .normal)
        userInfoButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchButton), UIBarButtonItem(customView: userInfoButton)]
        
    }
    @objc private func searchButtonTapped() {
        print("searchButtonTapped")
    }
}
