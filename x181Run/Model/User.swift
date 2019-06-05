//
//  User.swift
//  x181Run
//
//  Created by Peter Forward on 6/4/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

var loggedInUser: User? = nil

struct User {
    let username: String
    let email: String
    
    init?(username: String, email: String) {
        self.username = username
        self.email = email
    }
}


//func setUser(username: String, email: String, username: String?) {
//}
