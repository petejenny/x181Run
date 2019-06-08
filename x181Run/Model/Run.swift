//
//  Run.swift
//  x181Run
//
//  Created by Peter Forward on 5/31/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

protocol IdentifiableFirestoreDocId {
    var id: String? {get set}
}

struct Run: Codable, IdentifiableFirestoreDocId {
    var id: String? = nil // default value nil
    
    let runName: String
    let runDate: String
    let runText: String
    //let medalImage: UIImage
    
    init(runName: String, runDate: String, runText: String) {
        self.runName = runName
        self.runDate = runDate
        self.runText = runText
        //self.medalImage = medalImage
    }
}
