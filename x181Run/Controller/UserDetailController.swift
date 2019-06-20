//
//  UserDetailController.swift
//  x181Run
//
//  Created by Peter Forward on 6/13/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit
import Firebase

class UserDetailController: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "cartoonRunner")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
 
    let userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        return label
    } ()
    
    let userEmailValue: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.email
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = runLightYellowColor
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        return label
    } ()
    
    let userNameValue: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.displayName
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = runLightYellowColor
        return label
    } ()
    
    let userIdLabel: UILabel = {
        let label = UILabel()
        label.text = "User ID"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        return label
    } ()
    
    let userIdValue: UILabel = {
        let label = UILabel()
        label.text = Auth.auth().currentUser?.uid
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        label.backgroundColor = runLightYellowColor
        return label
    } ()
    
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func okButtonTapped() {
        print("okButtonTapped")
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        navigationItem.title = "Login Controller"
        
        //let xxx = Auth.auth().currentUser?.isEmailVerified
        
        
        view.addSubview(userEmailLabel)
        view.addSubview(userEmailValue)
        view.addSubview(userNameLabel)
        view.addSubview(userNameValue)
        view.addSubview(userIdLabel)
        view.addSubview(userIdValue)
        view.addSubview(okButton)
        
        
        view.addSubview(logoImageView)
        
        userEmailLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        userEmailValue.anchor(userEmailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 6, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        userNameLabel.anchor(userEmailValue.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        userNameValue.anchor(userNameLabel.bottomAnchor, left: userEmailLabel.leftAnchor, bottom: nil, right: userEmailLabel.rightAnchor, topConstant: 6, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        userIdLabel.anchor(userNameValue.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        userIdValue.anchor(userIdLabel.bottomAnchor, left: userEmailLabel.leftAnchor, bottom: nil, right: userEmailLabel.rightAnchor, topConstant: 6, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        okButton.anchor(userIdValue.bottomAnchor, left: userEmailLabel.leftAnchor, bottom: nil, right: userEmailLabel.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        logoImageView.anchor(okButton.bottomAnchor, left: userEmailLabel.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: userEmailLabel.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
