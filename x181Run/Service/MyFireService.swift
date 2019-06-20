//
//  MyFireService.swift
//  x181Run
//
//  Created by Peter Forward on 6/5/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Firebase

var myImageReference: StorageReference {
    return Storage.storage().reference().child("/users/" + (Auth.auth().currentUser?.uid)! + "/events")
}
