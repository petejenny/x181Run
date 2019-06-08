//
//  User.swift
//  x181Run
//
//  Created by Peter Forward on 6/4/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

var xloggedInUser: User? = nil

struct User {
    var username: String
    var email: String
    
    init?(username: String, email: String) {
        self.username = username
        self.email = email
    }
    
    mutating func update(username: String, email: String) {
        self.username = username
        self.email = email
    }

    
}


//func setUser(username: String, email: String, username: String?) {
//}
