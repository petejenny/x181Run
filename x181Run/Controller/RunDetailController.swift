//
//  RunDetail.swift
//  x181Run
//
//  Created by Peter Forward on 6/7/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class RunDetailController: UIViewController {
    
    var myRunMode: runMode = .Read
    var myRun = Run(eventTitle: "none", eventDate: "none", eventLocation: "none", eventDistance: "none")
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "cartoonRunner")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let eventTitleTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Event Title"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        //textField.keyboardType = .
        textField.backgroundColor = .white
        return textField
    }()
    
    let eventDateTextField: LeftPaddedTextField = {
        let eventDateTextField = LeftPaddedTextField()
        eventDateTextField.placeholder = "Event Date"
        //eventDateTextField.datePickerMode = .date
        eventDateTextField.layer.borderColor = UIColor.lightGray.cgColor
        eventDateTextField.layer.borderWidth = 1
        eventDateTextField.backgroundColor = .white
        return eventDateTextField
    }()
    
    let eventLocationTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Event Location"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        return textField
    }()
    
    let eventDistanceTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Event Distance"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitle(myRunMode.rawValue, for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonTapped(_:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
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
        
        print("Run Mode=", myRunMode)
        
        navigationItem.title = "Login Controller"
        
        view.addSubview(eventTitleTextField)
        view.addSubview(eventDateTextField)
        view.addSubview(eventLocationTextField)
        view.addSubview(eventDistanceTextField)
        
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
            
            eventTitleTextField.text = myRun.eventTitle
            eventDateTextField.text = myRun.eventDate
            eventLocationTextField.text = myRun.eventLocation
            eventDistanceTextField.text = myRun.eventDistance
            
        } else if myRunMode == .Update {
            eventTitleTextField.text = myRun.eventTitle
            eventDateTextField.text = myRun.eventDate
            eventLocationTextField.text = myRun.eventLocation
            eventDistanceTextField.text = myRun.eventDistance
            
            deleteButton.isHidden = false
        }
        
        // Date Picker Code
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        eventDateTextField.inputView = datePicker
        eventDateTextField.inputAccessoryView = dateToolbar
        
        eventTitleTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        eventDateTextField.anchor(eventTitleTextField.bottomAnchor, left: eventTitleTextField.leftAnchor, bottom: nil, right: eventTitleTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        eventLocationTextField.anchor(eventDateTextField.bottomAnchor, left: eventTitleTextField.leftAnchor, bottom: nil, right: eventTitleTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        eventDistanceTextField.anchor(eventLocationTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        actionButton.anchor(eventDistanceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
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
