//
//  MyFireLoginService.swift
//  x181Run
//
//  Created by Peter Forward on 6/4/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import Firebase

struct MyFireLoginService {
    
    static let sharedInstance = MyFireLoginService()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    func login(vc: UIViewController, email: String, password: String) {
        
        let sv = UIViewController.displaySpinner(onView: vc.view)
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
            UIViewController.removeSpinner(spinner: sv)
            guard error == nil else {
                AlertController.showAlert(inViewController: vc, title: "Login: Error", message: error!.localizedDescription)
                return
            }
            
            guard let user = user else {return}
            print("User Email:",user.user.email ?? "MISSING EMAIL")
            print("User Displayname:",user.user.displayName ?? "MISSING DISPLAY NAME")
            print("User Uid:",user.user.uid)
            
            // Set the view controller back to the RunDatasourceController
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
            
            mainNavigationController.viewControllers = [RunDatasourceController()]
            
            UserDefaults.standard.setLoginEmail(value: email)
            UserDefaults.standard.setLoginPassword(value: password)
            UserDefaults.standard.setIsLoggedIn(value: true)
            print("LoginController isLoggedIn=",UserDefaults.standard.isLoggedIn())
            
            vc.dismiss(animated: true, completion: nil)
        })
    }
    
    func signup(vc: UIViewController, username: String, email: String, password: String) {
        
        let sv = UIViewController.displaySpinner(onView: vc.view)
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            UIViewController.removeSpinner(spinner: sv)
            guard error == nil else {
                AlertController.showAlert(inViewController: vc, title: "Signup: Error", message: error!.localizedDescription)
                return
            }
            
            guard let user = user else {return}
            print(user.user.email ?? "MISSING EMAIL")
            print(user.user.uid)
            
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: {(error) in
                guard error == nil else {
                    AlertController.showAlert(inViewController: vc, title: "Signup Username: Error", message: error!.localizedDescription)
                    return
                }
                
                // Set the view controller back to the RunDatasourceController
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                
                mainNavigationController.viewControllers = [RunDatasourceController()]
                
                UserDefaults.standard.setLoginEmail(value: email)
                UserDefaults.standard.setLoginPassword(value: password)
                UserDefaults.standard.setIsLoggedIn(value: true)
                
                xloggedInUser?.email = email
                xloggedInUser?.username = username
                
                print("LoginController isLoggedIn=",UserDefaults.standard.isLoggedIn())
                
                vc.dismiss(animated: true, completion: nil)
                
            })
        })
    }
    
    func logout(vc: UIViewController) {
        
        let sv = UIViewController.displaySpinner(onView: vc.view)
        
        do {
            try Auth.auth().signOut()
        } catch let signoutError as NSError {
            AlertController.showAlert(inViewController: vc, title: "Logout: Error", message: signoutError.localizedDescription)
        }
        
        UserDefaults.standard.setIsLoggedIn(value: false)
        UIViewController.removeSpinner(spinner: sv)
        
    }
    
}
