//
//  UiHelper.swift
//  x181Run
//
//  Created by Peter Forward on 6/24/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

func labelHelper(labelText: String) -> UILabel {
    let label = UILabel()
    label.text = labelText
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = NSTextAlignment.center
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
    label.backgroundColor = lightYellow
    label.layer.borderColor = UIColor.clear.cgColor
    label.layer.borderWidth = 2
    return label
}

func labelValueHelper(labelText: String) -> UILabel {
    let label = UILabel()
    label.text = labelText
    label.font = UIFont.systemFont(ofSize: 15)
    label.textAlignment = NSTextAlignment.center
    label.layer.cornerRadius = 8
    label.layer.masksToBounds = true
    label.layer.borderColor = UIColor.lightGray.cgColor
    label.layer.borderWidth = 2
    label.backgroundColor = runLightYellowColor
    return label
}

func textHelper(placeHolderText: String) -> LeftPaddedTextField {
    let textField = LeftPaddedTextField()
    textField.placeholder = placeHolderText
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.layer.borderWidth = 1
    textField.backgroundColor = .white
    textField.layer.cornerRadius = 8
    textField.layer.masksToBounds = true
    return textField
}

