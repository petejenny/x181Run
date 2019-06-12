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
    
    let eventTitle: String
    let eventDate: String
    let eventLocation: String
    let eventDistance: String
    //let medalImage: UIImage
    
    init(eventTitle: String, eventDate: String, eventLocation: String, eventDistance: String) {
        self.eventTitle = eventTitle
        self.eventDate = eventDate
        self.eventLocation = eventLocation
        self.eventDistance = eventDistance
        //self.medalImage = medalImage
    }
}
