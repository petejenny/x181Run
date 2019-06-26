//
//  RunDetail.swift
//  x181Run
//
//  Created by Peter Forward on 6/7/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

//import UIKit
import LBTAComponents

class RunDetailController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var myRunMode: runMode = .Read
    var myRun1 = Run(eventTitle: "none", eventDate: "none", eventLocation: "none", eventDistance: "none", eventImage: "none")
    var myRunDateAsDate: Date = Date()
    var imageUpdated: Bool = false
    
    let logoImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "cartoonRunner")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let eventTitleLabel =   labelHelper(labelText: "Title")
    let eventTitleTextField = textHelper(placeHolderText: "Event Title")
    
    let eventDateLabel = labelHelper(labelText: "Date")

    let eventDateTextField: LeftPaddedTextField = textHelper(placeHolderText: "Event Date")
    
    let eventLocationLabel = labelHelper(labelText: "Location")
    let eventLocationTextField = textHelper(placeHolderText: "Event Location")
 
    
    let eventDistanceLabel = labelHelper(labelText: "Distance")
    let eventDistanceTextField = textHelper(placeHolderText: "Event Distance")
    
    let finalTimeLabel = labelHelper(labelText: "Final Time")
    let finalTimeTextField = textHelper(placeHolderText: "Final Time")
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitle(myRunMode.rawValue, for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let medalImage: CachedImageView  = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "addIcon")
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    } ()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitle(runMode.Delete.rawValue, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var dateToolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        toolbar.barStyle = .blackTranslucent
        toolbar.tintColor = .white
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(dateTodayButtonTapped(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDoneButtonTapped(_:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
        label.text = "select a date"
        label.textColor = .yellow
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        let labelButton = UIBarButtonItem(customView: label)
        toolbar.setItems([todayButton, flexButton, labelButton, flexButton, doneButton], animated: true)
        return toolbar
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        //print("Run Mode=", myRunMode)
        
        navigationItem.title = "Run Detail Controller"
        
        //MARK: Tap Guesture for medal image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        medalImage.isUserInteractionEnabled = true
        medalImage.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(eventTitleLabel)
        view.addSubview(eventTitleTextField)
        
        view.addSubview(eventDateLabel)
        view.addSubview(eventDateTextField)
        
        view.addSubview(eventLocationLabel)
        view.addSubview(eventLocationTextField)
        
        view.addSubview(eventDistanceLabel)
        view.addSubview(eventDistanceTextField)
        
        view.addSubview(finalTimeLabel)
        view.addSubview(finalTimeTextField)
        
        view.addSubview(medalImage)
        
        view.addSubview(actionButton)
        view.addSubview(deleteButton)
        view.addSubview(cancelButton)
        
        view.addSubview(logoImageView)
        
        if myRunMode == .Read {
            eventTitleTextField.isEnabled = false
            eventDateTextField.isEnabled = false
            eventLocationTextField.isEnabled = false
            eventDistanceTextField.isEnabled = false
            actionButton.isHidden = true
            
            eventTitleTextField.text = myRun1.eventTitle
            myRunDateAsDate = fireDate2Date(fireDateString: myRun1.eventDate)
            eventDateTextField.text = date2DisplayDate(myDate: myRunDateAsDate)
            eventLocationTextField.text = myRun1.eventLocation
            eventDistanceTextField.text = myRun1.eventDistance
            
        } else if myRunMode == .Update {
            eventTitleTextField.text = myRun1.eventTitle
            myRunDateAsDate = fireDate2Date(fireDateString: myRun1.eventDate)
            eventDateTextField.text = date2DisplayDate(myDate: myRunDateAsDate)
            eventLocationTextField.text = myRun1.eventLocation
            eventDistanceTextField.text = myRun1.eventDistance
            
            deleteButton.isHidden = false
        }
        
        dateSetupDatePicker()
        
        eventTitleLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 40)
        eventTitleTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: eventTitleLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)

        eventDateLabel.anchor(eventTitleTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 40)
        eventDateTextField.anchor(eventTitleTextField.bottomAnchor, left: eventTitleLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        eventLocationLabel.anchor(eventDateTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 40)
        eventLocationTextField.anchor(eventDateTextField.bottomAnchor, left: eventTitleLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        eventDistanceLabel.anchor(eventLocationTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 40)
        eventDistanceTextField.anchor(eventLocationTextField.bottomAnchor, left: eventTitleLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        finalTimeLabel.anchor(eventDistanceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 100, heightConstant: 40)
        finalTimeTextField.anchor(eventDistanceTextField.bottomAnchor, left: eventTitleLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        medalImage.anchor(finalTimeTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 150)
        
        
        actionButton.anchor(medalImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        if myRunMode == .Update {
            // Set the date for the datepicker
            
            
            // Display Delete button and CancelButton
            deleteButton.anchor(actionButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
            cancelButton.anchor(deleteButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        } else {
            // Only display Cancel button
            cancelButton.anchor(actionButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        }
        
        logoImageView.anchor(cancelButton.bottomAnchor, left: eventTitleTextField.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: eventTitleTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
