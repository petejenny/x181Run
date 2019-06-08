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

struct Service {
    
    let tron = TRON(baseURL: tronBaseUrl)
    
    static let sharedInstance = Service()
    
    func fetchRunFeed(completion: @escaping (RunDatasource?, Error?) -> ()) {
        print("Fetching run feed")
        
        let request: APIRequest<RunDatasource, JSONError> = tron.swiftyJSON.request("/twitter/home")
        
        request.perform(withSuccess: { (runDatasource) in
            print("Successfully fetched json objects",runDatasource.runs.count)
            
            completion(runDatasource, nil)
            
        }) { (err) in
            completion(nil,err)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON ERROR")
        }
    }
}
