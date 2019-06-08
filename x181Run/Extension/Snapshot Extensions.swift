//
//  Snapshot Extensions.swift
//  x181Run
//
//  Created by Peter Forward on 6/6/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    
    // function to create object from json
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        
        var documentJson = data()
        if includingId {
            documentJson?["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson!, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
    
}
