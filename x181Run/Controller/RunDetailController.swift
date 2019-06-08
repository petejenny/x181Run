//
//  RunDetail.swift
//  x181Run
//
//  Created by Peter Forward on 6/7/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

class RunDetailController: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "cartoonRunner")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let eventTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Event Name"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        //textField.keyboardType = .
        textField.backgroundColor = .white
        return textField
    }()
    
    let eventDateField: UIDatePicker = {
        let dateField = UIDatePicker()
        //dateField.placeholder = "Event Date"

        dateField.layer.borderColor = UIColor.lightGray.cgColor
        dateField.layer.borderWidth = 1
        dateField.backgroundColor = .white
        return dateField
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

    lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
    
    @objc func addButtonTapped() {
        print("addButtonTapped")

        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        print("addButtonTapped")
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        navigationItem.title = "Login Controller"
        
        view.addSubview(eventTextField)
        view.addSubview(eventDateField)
        view.addSubview(eventLocationTextField)
        view.addSubview(eventDistanceTextField)
        
        view.addSubview(addButton)
        view.addSubview(cancelButton)
        
        
        view.addSubview(logoImageView)
        
        eventTextField.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        eventDateField.anchor(eventTextField.bottomAnchor, left: eventTextField.leftAnchor, bottom: nil, right: eventTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        eventLocationTextField.anchor(eventDateField.bottomAnchor, left: eventTextField.leftAnchor, bottom: nil, right: eventTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        eventDistanceTextField.anchor(eventLocationTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 24, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        addButton.anchor(eventDistanceTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        cancelButton.anchor(addButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 12, widthConstant: 0, heightConstant: 40)
        
        logoImageView.anchor(cancelButton.bottomAnchor, left: eventTextField.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: eventTextField.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
