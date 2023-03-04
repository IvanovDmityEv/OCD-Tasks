//
//  ObserverKeyboard.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.02.2023.
//

import Foundation
import UIKit

extension AddTasksVC {
    
    func observerKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let edgeInsets: UIEdgeInsets = .init(top: 0, left: 0, bottom: keyboardFrame.height - view.safeAreaInsets.bottom, right: 0)
            tableView.contentInset = edgeInsets
            tableView.scrollIndicatorInsets = edgeInsets
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentInset = .zero
        tableView.scrollIndicatorInsets = .zero
    }
}
