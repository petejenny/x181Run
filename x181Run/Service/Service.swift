//
//  Service.swift
//  x181Run
//
//  Created by Peter Forward on 6/4/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

let tronBaseUrl = "https://api.letsbuildthatapp.com"

struct oldService {
    
    let tron = TRON(baseURL: tronBaseUrl)
    
    static let sharedInstance = oldService()
    
    func oldfetchRunFeed(completion: @escaping (oldRunDatasource?, Error?) -> ()) {
        print("Fetching run feed")
        
        let request: APIRequest<oldRunDatasource, oldJSONError> = tron.swiftyJSON.request("/twitter/home")
        
        request.perform(withSuccess: { (runDatasource) in
            print("Successfully fetched json objects",runDatasource.runs.count)
            
            completion(runDatasource, nil)
            
        }) { (err) in
            completion(nil,err)
        }
    }
    
    class oldJSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}
