//
//  AlertController.swift
//  OCRTasks
//
//  Created by Dmitriy on 27.12.2022.
//

import Foundation
import UIKit


class AlertController {

    func dateAlertController(date: Date?) -> (){
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let dateAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateAlertController.view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateAlertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        datePicker.centerXAnchor.constraint(equalTo: dateAlertController.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: dateAlertController.view.topAnchor, constant: 30).isActive = true
        
        
//        if date != nil {
//            datePicker.date = date!
//        }
//        
//        let clearDate = UIAlertAction(title: "Clear", style: .default) { [weak self] (action) in
//            self?.date = nil
//            self?.dateString = nil
//            guard let timeString = self?.timeString else {
//                self?.dateTasks.text = ""
//                return
//            }
//            self?.dateTasks.text = timeString
//        }
//        
//        let saveDate = UIAlertAction(title: "Save", style: .default) { [weak self] (action) in
//            
//            let dateFormater = DateFormatter()
//            dateFormater.dateStyle = .medium
//            
//            self?.dateString = dateFormater.string(from: datePicker.date)
//            self?.date = datePicker.date
//            
//        }
//        dateAlertController.addAction(clearDate)
//        dateAlertController.addAction(saveDate)
//        
//        present(dateAlertController, animated: true)
    }
}
