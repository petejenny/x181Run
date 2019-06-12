//
//  RunDetailController+.swift
//  x181Run
//
//  Created by Peter Forward on 6/10/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import UIKit

extension RunDetailController {
    
    @objc func todayButtonTapped(_ sender: UIDatePicker) {
        print ("todayButtonTapped")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        //dateFormatter.dateFormat = "yyy-MMM-dd"
        dateFormatter.dateFormat = "MMMM dd yyyy"
        
        eventDateTextField.text = dateFormatter.string(from: Date())
        
        eventDateTextField.resignFirstResponder()
    }
    
    @objc func doneButtonTapped(_ sender: UIDatePicker){
        print("doneButtonTapped")
        eventDateTextField.resignFirstResponder()
    }
    
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
        MyFireDbService.sharedInstance.myDelete(myRun, in: .runEvents)
    }
    
    private func doCreateProcessing() {
        // Get the values
        let eventName = eventTitleTextField.text
        let displayDate = eventDateTextField.text
        let eventLocation = eventLocationTextField.text
        let eventDistance = eventDistanceTextField.text
        let fireDate = displayDateToFireDate(displayDate: displayDate!)
        
        let newRun = Run(eventTitle: eventName ?? "No event name entered", eventDate: fireDate ?? "No run date entered", eventLocation: eventLocation ?? "No location provided", eventDistance: eventDistance ?? "No distance provided")
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
        let displayDate = eventDateTextField.text
        let eventLocation = eventLocationTextField.text
        let eventDistance = eventDistanceTextField.text
        let fireDate = displayDateToFireDate(displayDate: displayDate!)
        let runText = eventDistanceTextField.text
        
        var updatedRun = Run(eventTitle: eventName ?? "No event name entered", eventDate: fireDate ?? "No run date enetered", eventLocation: eventLocation ?? "No location provided", eventDistance: eventDistance ?? "No distance provided")
        updatedRun.id = myRun.id
        
        MyFireDbService.sharedInstance.myUpdate(for: updatedRun, in: .runEvents)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        print("cancelButtonTapped")
        
        // For debugging only
        let runDate: String = eventDateTextField.text ?? ""
        print("Run Date=",runDate)
        
        // Set the view controller back to the RunDatasourceController
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [RunDatasourceController()]
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .none
        //formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.dateFormat = "MMMM dd yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        eventDateTextField.text = formatter.string(from: sender.date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


//let fireDateString = run.eventDate
//let fireDateFormatter = DateFormatter()
//fireDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//let fireDateValue = fireDateFormatter.date(from: fireDateString)
//let displayDateFormatter = DateFormatter()
//displayDateFormatter.dateFormat = "MMM dd YYYY"
////let displayDateString = displayDateFormatter.string(from: fireDateValue!)
//let displayDateString = "July 11 2019"
//eventDateLabel.text = displayDateString


let fireDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let dispDateFormat = "MMM dd YYYY"

 func fireDateToDisplayDate(fireDate: String) -> String {
    let formatter1 = DateFormatter()
    formatter1.dateFormat = fireDateFormat
    let dateValue = formatter1.date(from: fireDate)
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = dispDateFormat
    let dateString = formatter2.string(from: dateValue!)
    return dateString
}

 func displayDateToFireDate(displayDate: String) -> String {
    let formatter1 = DateFormatter()
    formatter1.dateFormat = dispDateFormat
    let dateValue = formatter1.date(from: displayDate)
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = fireDateFormat
    let dateString = formatter2.string(from: dateValue!)
    
    return dateString
}
