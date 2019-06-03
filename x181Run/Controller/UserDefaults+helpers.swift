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
        case userEmail
        case userpassword
    }
    
    func setIsLoggedIn(value: Bool)  {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
