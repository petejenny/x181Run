//
//  HomeDatasource.swift
//  x181Run
//
//  Created by Peter Forward on 5/30/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    let runs: [Run] = {
        let wildcat = Run(runName: "Wildcat Peak", runDate: "11-May-2017", runText: "Half Marathon 3:30:00", medalImage: #imageLiteral(resourceName: "wildcatPeak"))
        let diablo = Run(runName: "Diablo 50k", runDate: "11-May-2011", runText: "50K 7:30:00", medalImage: #imageLiteral(resourceName: "wildcatPeak"))
        let badger = Run(runName: "Badger Cove", runDate: "11-Feb-2018", runText: "Half Marathon 2:45:00 This was an extremelly cold day combined with mud, wind, rain and hail.  There were also a lot of cows on the course - especially near the finish line.", medalImage: #imageLiteral(resourceName: "wildcatPeak"))
        return [wildcat, diablo, badger]
    }()
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [RunHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [RunFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [runCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return runs[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return runs.count
    }
    
}
