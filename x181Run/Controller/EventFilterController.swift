//
//  EventFilterController.swift
//  x181Run
//
//  Created by Peter Forward on 6/17/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class EventFilterController: UIViewController {
    
    let sortFields = [
        "eventTitle",
        "eventDate",
        "eventLocation",
        "eventDistance"]
    
    var defaultSortField: String?
    var selectedSortField: String?
    
    
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "cartoonRunner")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let sortOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort Order"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 2
        return label
    } ()
    
    let sortOrderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Sort Order"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        //textField.keyboardType = .
        textField.backgroundColor = .white
        //textField.addTarget(self, action: #selector, for: <#T##UIControl.Event#>)
        return textField
    }()
    
    let eventDateTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Event Date"
        //textField.datePickerMode = .date
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .white
        return textField
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
    
    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func okButtonTapped() {
        print("okButtonTapped")
        
        UserDefaults.standard.setSortOrder(value: selectedSortField!)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func cancelButtonTapped() {
        print("cancelButtonTapped")
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        
        navigationItem.title = "Filter Controller"
        
        sortOrderTextField.text = defaultSortField
        
        view.addSubview(sortOrderLabel)
        view.addSubview(sortOrderTextField)
        //view.addSubview(eventLocationTextField)
        //view.addSubview(eventDistanceTextField)
        
        view.addSubview(okButton)
        //.view.addSubview(deleteButton)
        view.addSubview(cancelButton)
        
        view.addSubview(logoImageView)
        
        sortOrderLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        sortOrderTextField.anchor(sortOrderLabel.bottomAnchor, left: sortOrderLabel.leftAnchor, bottom: nil, right: sortOrderLabel.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        okButton.anchor(sortOrderTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
      cancelButton.anchor(okButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        logoImageView.anchor(cancelButton.bottomAnchor, left: sortOrderLabel.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: sortOrderLabel.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        createSortOrderPicker()
    }
    
    func createSortOrderPicker() {
        let sortOrderPicker = UIPickerView()
        sortOrderPicker.delegate = self
        
        sortOrderTextField.inputView = sortOrderPicker
    }
    
}



extension EventFilterController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortFields.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortFields[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSortField = sortFields[row]
        sortOrderTextField.text = selectedSortField
    }
}
