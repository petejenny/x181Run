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
    
    override var datasourceItem: Any? {
        didSet {
            // Downcast datasource item as run object
            guard let run = datasourceItem as? Run else {return}
            eventTitleLabel.text = run.eventTitle
            
            let fireDateString = run.eventDate
            eventDateLabel.text = fireDateToDisplayDate(fireDate: fireDateString)
            
            runTextView.text = run.eventLocation
            
            if run.eventImage == "None" {
                print("No eventImage: ", run.eventImage)
                // Display the default image
            } else {
                print("We have an image: ", run.eventImage)
                // get the actual image
                let filename = run.eventImage  + ".jpg"
                let downloadImageRef = myImageReference.child(filename)
                let _ = downloadImageRef.getData(maxSize: 1024 * 1024 * 12) { (data, error) in
                    if let data = data {
                        let image = UIImage(data: data)
                        //download completed
                        self.medalImage.image = image
                        //self.downloadImage.image = image
                    }
                    print(error ?? "NO ERROR")
                }
//
//                downloadTask.observe(.progress) { (snapshot) in
//                    print("Progress:",snapshot.progress ?? "NO MORE PROGRESS")
//
//                    downloadTask.resume()
//                }
            }
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
    
    let eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Joe Bloggs"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    } ()
    
    let eventDateLabel: UILabel = {
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
    
    lazy var infoButton: UIButton = {
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
        
        button.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        return button
    } ()
    
    @objc func infoButtonTapped() {
    
        guard let thisRun = datasourceItem as? Run else {return}
        print("infoButtonTapped: " , thisRun.id ?? "** WARNING - Has No ID **")
        
        let runDetailController = RunDetailController()
        //runDetailController.myRunMode = .Read
        runDetailController.myRunMode = .Update
        runDetailController.myRun1 = thisRun
        runDetailController.medalImage.image = medalImage.image
        //RunDetailController.myRunDateAsDate = fireDate2Date(fireDate: thisRun.eventDate)
        
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //myAppDelegate.myRunDatasourceController = self
        myAppDelegate.myRunDatasourceController!.present(runDetailController, animated: true, completion: nil)
    }
    
    override func setupViews() {
        super.setupViews()
        //backgroundColor = .yellow
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(eventTitleLabel)
        addSubview(medalImage)
        addSubview(eventDateLabel)
        addSubview(runTextView)
        addSubview(infoButton)
        
        // Medal Image at top left of cell
        medalImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 50)
        
        // Run Button
        infoButton.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 34)
        
        // Run Name
        eventTitleLabel.anchor(medalImage.topAnchor, left: medalImage.rightAnchor, bottom: nil, right: infoButton.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 20)
        
        // Run Date
        eventDateLabel.anchor(eventTitleLabel.bottomAnchor, left: eventTitleLabel.leftAnchor, bottom: nil, right: eventTitleLabel.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        // Run Text
        runTextView.anchor(eventDateLabel.bottomAnchor, left: eventDateLabel.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: -4, leftConstant: -4, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
