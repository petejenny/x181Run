//
//  DateFunctions.swift
//  x181Run
//
//  Created by Peter Forward on 6/13/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation


let fireDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
let dispDateFormat = "MMM dd YYYY"

func date2FireDate(myDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = fireDateFormat
    let fireDateString = formatter.string(from: myDate)
    return fireDateString
}

func date2DisplayDate(myDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = dispDateFormat
    let displayDateString = formatter.string(from: myDate)
    return displayDateString
}

func fireDate2Date(fireDateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = fireDateFormat
    let dateValue = formatter.date(from: fireDateString)
    
    return dateValue ?? Date()
}

func displayDate2Date(displayDateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = dispDateFormat
    let dateValue = formatter.date(from: displayDateString)
    
    return dateValue ?? Date()
}

func fireDateToDisplayDate(fireDate: String) -> String {
    
    let dateValue = fireDate2Date(fireDateString: fireDate)
    let displayDate = date2DisplayDate(myDate: dateValue)
    return displayDate
}

func displayDateToFireDate(displayDate: String) -> String {
 
    let dateValue = displayDate2Date(displayDateString: displayDate)
    let fireDate = date2FireDate(myDate: dateValue)
    
    return fireDate
}
