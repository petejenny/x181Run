//
//  RunCell.swift
//  x181Run
//
//  Created by Peter Forward on 5/31/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import LBTAComponents

// Renders out run data
class runCell: DatasourceCell {
    
    //    override var datasourceItem: Any? {
    //        didSet {
    //            runNameLabel.text = datasourceItem as? String
    //        }
    //    }
    
    override var datasourceItem: Any? {
        didSet {
            // Downcast datasource item as run object
            guard let run = datasourceItem as? Run else {return}
            runNameLabel.text = run.runName
            runDateLabel.text = run.runDate
            runTextView.text = run.runText
            //medalImage.image = run.medalImage
        }
    }
    
    let medalImage: UIImageView  = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wildcatPeak")
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    } ()
    
    let runNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joe Bloggs"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    let runDateLabel: UILabel = {
        let label = UILabel()
        label.text = "11-May-2010"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(r: 130, g: 130, b: 130)
        return label
    } ()
    
    let runTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Half Marathon 03:30:00"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .clear
        return textView
    } ()
    
    lazy var runButton: UIButton = {
        let button = UIButton()
        
        button.layer.borderColor = runThemeColor.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Info", for: .normal)
        button.setTitleColor(runThemeColor, for: .normal)
        button.setImage(#imageLiteral(resourceName: "infoIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        //button.titleEdgeInsets =
        
        button.addTarget(self, action: #selector(runButtonTapped), for: .touchUpInside)
        
        return button
    } ()
    
    @objc func runButtonTapped() {
    print("run info button invoked")
    }
    
    override func setupViews() {
        super.setupViews()
        //backgroundColor = .yellow
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(runNameLabel)
        addSubview(medalImage)
        addSubview(runDateLabel)
        addSubview(runTextView)
        addSubview(runButton)
        
        // Medal Image at top left of cell
        medalImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        // Run Button
        runButton.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 34)
        
        // Run Name
        runNameLabel.anchor(medalImage.topAnchor, left: medalImage.rightAnchor, bottom: nil, right: runButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        // Run Date
        runDateLabel.anchor(runNameLabel.bottomAnchor, left: runNameLabel.leftAnchor, bottom: nil, right: runNameLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        // Run Text
        runTextView.anchor(runDateLabel.bottomAnchor, left: runDateLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: -4, leftConstant: -4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
}

