//
//  LoginController.swift
//  x181Run
//
//  Created by Peter Forward on 6/1/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit
//import Firebase

//let warningColor = UIColor(r: 61, g: 167, b: 244)
let warningColor = UIColor(r: 255, g: 167, b: 167)

class LoginController: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "cartoonRunner")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginEmailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        if let loginEmailText = UserDefaults.standard.getLoginEmail() {
            textField.text = loginEmailText
        }
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .white
        return textField
    }()
    
    let loginPasswordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        if let loginPasswordText = UserDefaults.standard.getLoginPassword() {
            textField.text = loginPasswordText
        }
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    let signupUsernameTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter Username"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        return textField
    }()

    
    let signupEmailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let signupPasswordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    let signupVerifyTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Verify password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.backgroundColor = .white
        return textField
    }()
    
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
  
    
    @objc func loginButtonTapped() {
        print("loginButtonTapped")
        
        // Validate values entered
        guard let email = loginEmailTextField.text,
            email != "",
            let password = loginPasswordTextField.text,
            password != ""
            else {
                AlertController.showAlert(inViewController: self, title: "Login: Missing Info", message: "Please fill out login fields")
                
                return
        }
        
        firebaseLogin(vc: self, email: email, password: password)
        
    }
    
    
    @objc func signupButtonTapped() {
        print("signupButtonTapped")
     
        loginEmailTextField.isUserInteractionEnabled = false
        
        guard let username = signupUsernameTextField.text, username != ""
            else {
                signupUsernameTextField.becomeFirstResponder()
                signupUsernameTextField.backgroundColor =  warningColor
                AlertController.showAlert(inViewController: self, title: "Signup: Missing Info", message: "Please fill out SIgn Up fields")
                return
        }
        signupUsernameTextField.backgroundColor = .white
        
        guard let email = signupEmailTextField.text, email != ""
            else {
                signupEmailTextField.becomeFirstResponder()
                signupEmailTextField.backgroundColor =  warningColor
                AlertController.showAlert(inViewController: self, title: "Signup: Missing Info", message: "Please fill out SIgn Up fields")
                return
        }
        signupEmailTextField.backgroundColor =  .white
        
        guard let password = signupPasswordTextField.text, password != ""
            else {
                signupPasswordTextField.becomeFirstResponder()
                signupPasswordTextField.backgroundColor =  warningColor
                AlertController.showAlert(inViewController: self, title: "Signup: Missing Info", message: "Please fill out SIgn Up fields")
                return
        }
        signupPasswordTextField.backgroundColor =  .white
        
        guard let verify = signupVerifyTextField.text, verify != ""
            else {
                signupVerifyTextField.becomeFirstResponder()
                signupVerifyTextField.backgroundColor =  warningColor
                AlertController.showAlert(inViewController: self, title: "Signup: Missing Info", message: "Please fill out SIgn Up fields")
                return
        }
        signupVerifyTextField.backgroundColor =  .white
        
        if password != verify {
            signupPasswordTextField.becomeFirstResponder()
            signupPasswordTextField.backgroundColor = warningColor
            signupVerifyTextField.backgroundColor =  warningColor
            AlertController.showAlert(inViewController: self, title: "Signup: Incorrect Info", message: "Passwords do not match")
            return
        }
        signupPasswordTextField.backgroundColor = .white
        signupVerifyTextField.backgroundColor =  .white
        
        firebaseSignup(vc: self, username: username, email: email, password: password)
        
        /*
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            guard error == nil else {
                AlertController.showAlert(inViewController: self, title: "Signup: Error", message: error!.localizedDescription)
                return
            }
            
            guard let user = user else {return}
            print(user.user.email ?? "MISSING EMAIL")
            print(user.user.uid)
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: {(error) in
                guard error == nil else {
                    AlertController.showAlert(inViewController: self, title: "Signup Username: Error", message: error!.localizedDescription)
                    return
                }
                
                // Set the view controller back to the RunDatasourceController
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                
                mainNavigationController.viewControllers = [RunDatasourceController()]
                
                UserDefaults.standard.setLoginEmail(value: email)
                UserDefaults.standard.setLoginPassword(value: password)
                UserDefaults.standard.setIsLoggedIn(value: true)
                print("LoginController isLoggedIn=",UserDefaults.standard.isLoggedIn())
                
                self.dismiss(animated: true, completion: nil)
                
            })
        })
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        navigationItem.title = "Login Controller"
        
        view.addSubview(loginEmailTextField)
        view.addSubview(loginPasswordTextField)
        view.addSubview(loginButton)
        
        view.addSubview(signupUsernameTextField)
        view.addSubview(signupEmailTextField)
        view.addSubview(signupPasswordTextField)
        view.addSubview(signupVerifyTextField)
        view.addSubview(signupButton)
        
        view.addSubview(logoImageView)
        
        loginEmailTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        loginPasswordTextField.anchor(loginEmailTextField.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: nil, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        loginButton.anchor(loginPasswordTextField.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: nil, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        signupUsernameTextField.anchor(loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        signupEmailTextField.anchor(signupUsernameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        signupPasswordTextField.anchor(signupEmailTextField.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: nil, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        signupVerifyTextField.anchor(signupPasswordTextField.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: nil, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        signupButton.anchor(signupVerifyTextField.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: nil, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)

        logoImageView.anchor(signupButton.bottomAnchor, left: loginEmailTextField.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: loginEmailTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
