//
//  AlertsAddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.02.2023.
//

import Foundation
import UIKit

extension AddTasksVC {
    
    func showAlertController(datePickerMode mode: UIDatePicker.Mode) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let color = UIColor(displayP3Red: 0.435, green: 0.376, blue: 0.718, alpha: 100)
        alertController.view.tintColor = color
        
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        
        if mode == .date {
            picker.datePickerMode = mode
        } else if mode == .time {
            picker.datePickerMode = mode
        }
        
        alertController.view.addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        alertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        picker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 30).isActive = true
        
        let dateFormater = DateFormatter()
        if mode == .date {
            if dateString != nil {
                dateFormater.dateStyle = .medium
                let data = dateFormater.date(from: dateString!)
                picker.date = data ?? .now
            }
            
        } else if mode == .time {
            if timeString != nil {
                dateFormater.timeStyle = .short
                let time = dateFormater.date(from: timeString!)
                picker.date = time ?? .now
            }
        }
        
        let actionClear = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            
            if mode == .date {
                self?.dateString = nil
                guard let timeString = self?.timeString else {
                    self?.dateTasks.text = ""
                    return
                }
                self?.dateTasks.text = timeString
            } else if mode == .time {
                self?.timeString = nil
                guard let dateString = self?.dateString else {
                    self?.dateTasks.text = ""
                    return
                }
                self?.dateTasks.text = dateString
            }
        }
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { [weak self] (action) in
            if mode == .date {
                dateFormater.dateStyle = .medium
                
                self?.dateString = dateFormater.string(from: picker.date)
            } else if mode == .time {
                dateFormater.timeStyle = .short
                
                self?.timeString = dateFormater.string(from: picker.date)
            }
        }
        alertController.addAction(actionClear)
        alertController.addAction(actionSave)
        
        DispatchQueue.main.async {
              self.present(alertController, animated: true, completion: nil)
          }
    }
}
