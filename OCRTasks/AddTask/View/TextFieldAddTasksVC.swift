//
//  TextFieldAddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.02.2023.
//

import Foundation
import UIKit


extension AddTasksVC: UITextFieldDelegate {
    
    //скрытие клавиатуры по нажатию Done
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTasksList.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if nameTasksList.text != "" {
            buttonSave.isEnabled = true
        } else {
            buttonSave.isEnabled = false
        }
    }
}
