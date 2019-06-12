//
//  Encodable Extensions.swift
//  x181Run
//
//  Created by Peter Forward on 6/6/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

extension Encodable {
    
    // Function to make json from an object
    // Function returns json.  json is a dictionary of string and any
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        
        // *** Convert object to data
        let testEncoder = JSONEncoder()
        testEncoder.outputFormatting = .prettyPrinted
        let objectData = try testEncoder.encode(self)
        //let objectData1 = try JSONEncoder().encode(self)
        // Now we have data
        
        // *** use json serialization to turn data to a json object
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        // the json object comes back as any.
        
        // TODO:
        // json object could be an array and that will need to be handled
        
        
        
        // *** Turn json objhect into json
        guard var json = jsonObject as? [String: Any] else {throw MyError.encodingError}
        
        // *** Remove any "excluding keys" values found in the json
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
}
