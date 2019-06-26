//
//  UserDefaults+helpers.swift
//  x181Run
//
//  Created by Peter Forward on 6/1/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case loginEmail
        case loginPassword
        case sortOrder
    }
    
    func setIsLoggedIn(value: Bool)  {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setLoginEmail(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.loginEmail.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getLoginEmail() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.loginEmail.rawValue)
    }
    
    func setLoginPassword(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.loginPassword.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getLoginPassword() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.loginPassword.rawValue)
    }
    
    func setSortOrder(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.sortOrder.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getSortOrder() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.sortOrder.rawValue) ?? "eventDate"
    }
}
