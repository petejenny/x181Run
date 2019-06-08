//
//  RunHeaderFooter.swift
//  x181Run
//
//  Created by Peter Forward on 5/30/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import LBTAComponents

let runThemeColor = UIColor(r: 61, g: 167, b: 244)

class RunFooter: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "That's all.  Go and run!"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = runThemeColor
        return label
    } ()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(r: 255, g: 255, b: 210)
        
        addSubview(textLabel)
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class RunHeader: DatasourceCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        
        let username = xloggedInUser?.username ?? "Unknown"
        label.text="Run Details for " + username
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = UIColor(r: 255, g: 255, b: 210)
        
        addSubview(textLabel)
        
        //textLabel.fillSuperview()
        textLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}


