//
//  RunDetailController+.swift
//  x181Run
//
//  Created by Peter Forward on 6/10/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit
import Firebase

extension RunDetailController {
    
    //MARK: Date Code Here
    func dateSetupDatePicker() {
        // Date Picker Code
        let datePicker = UIDatePicker()
        datePicker.date = myRunDateAsDate
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        eventDateTextField.inputView = datePicker
        eventDateTextField.inputAccessoryView = dateToolbar
    }
    
    @objc func dateTodayButtonTapped(_ sender: UIDatePicker) {
        
        myRunDateAsDate = Date()
        //print("todayButtonTapped Date=",myRunDateAsDate)
        eventDateTextField.text = date2DisplayDate(myDate: myRunDateAsDate)
        //print("todayButtonTapped Display=",eventDateTextField.text ?? "NO DATE")
        eventDateTextField.resignFirstResponder()
    }
    
    @objc func dateDoneButtonTapped(_ sender: UIDatePicker){
        print("doneButtonTapped")
        //myRunDateAsDate = sender.date
        //eventDateTextField.text = date2DisplayDate(myDate: myRunDateAsDate)
        eventDateTextField.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .none
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.dateFormat = dispDateFormat
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        myRunDateAsDate = sender.date
        eventDateTextField.text = date2DisplayDate(myDate: myRunDateAsDate)
        //eventDateTextField.text = formatter.string(from: sender.date)
    }
    
    //MARK: Process button actions
    @objc func actionButtonTapped() {
        print("actionButtonTapped")
        
        if myRunMode == .Create {
            doCreateProcessing()
        } else if myRunMode == .Update {
            doUpdateProcessing()
        }
    }
    
    @objc func deleteButtonTapped() {
        print("deleteButtonTapped")
        doDeleteProcessing()
    }
    
    func doDeleteProcessing() {
        MyFireDbService.sharedInstance.myDelete(myRun1, in: .runEvents)
    }
    
    private func doCreateProcessing() {
        // Get the values
        let eventName = eventTitleTextField.text
        let displayDate = eventDateTextField.text
        let eventLocation = eventLocationTextField.text
        let eventDistance = eventDistanceTextField.text
        let eventImage = "None"
        let fireDate = displayDateToFireDate(displayDate: displayDate!)
        
        let newRun = Run(eventTitle: eventName ?? "No event name entered", eventDate: fireDate , eventLocation: eventLocation ?? "No location provided", eventDistance: eventDistance ?? "No distance provided", eventImage: eventImage)
        MyFireDbService.sharedInstance.myCreate(for: newRun, in: .runEvents)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func doUpdateProcessing() {
        print("doUpdateProcessing")
        
        let eventName = eventTitleTextField.text
        //let displayDate = eventDateTextField.text
        let eventLocation = eventLocationTextField.text
        let eventDistance = eventDistanceTextField.text
        var eventImage = "None"
        let fireDate = date2FireDate(myDate: myRunDateAsDate)
        
        if imageUpdated {
            eventImage = UUID().uuidString
        }
        
        var updatedRun = Run(eventTitle: eventName ?? "No event name entered", eventDate: fireDate , eventLocation: eventLocation ?? "No location provided", eventDistance: eventDistance ?? "No distance provided", eventImage: eventImage)
        updatedRun.id = myRun1.id
        
        MyFireDbService.sharedInstance.myUpdate(for: updatedRun, in: .runEvents)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        if imageUpdated {
            // Get the documents directory for the application
            let imagePath = getDocumentsDirectory().appendingPathComponent(eventImage)
            
            MyFireStorageService.sharedInstance.myFireImageUpload(myImage: medalImage.image! , myImageRef: eventImage)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        print("cancelButtonTapped")
        
//        // For debugging only
//        let runDate: String = eventDateTextField.text ?? ""
//        print("Run Date=",runDate)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    //MARK: Image Code Here
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        //let tappedImage = tapGestureRecognizer.view as! UIImage
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //imagePickerController.allowsEditing = true
        
        // only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self 
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image.  You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Get the filename
//        if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
//            let resultResource = PHAssetResource.assetResources(for: asset)
//            print("FILENAME=",resultResource.firs.value(forKey: "filename"))
//        }


        
        // set photoImageView to display thee select image.
        medalImage.image = selectedImage
        
        imageUpdated = true
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


