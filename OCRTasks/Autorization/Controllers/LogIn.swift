//
//  LogIn.swift
//  OCRTasks
//
//  Created by Dmitriy on 06.02.2023.
//

import Foundation
import Firebase
import FirebaseDatabase

extension AutorizationVC {
    
func logIn(email: UITextField, password: UITextField) {
    guard let email = email.text,
            let password = password.text,
            email != "",
            password != "" else {
                warningAlertController(message: Messages.infoIsIncorrect.rawValue)
                return
            }
    
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.warningAlertController(message: Messages.errorOccurred.rawValue)
                return
            }
            if user != nil {
                return
            }
        self?.warningAlertController(message: Messages.noSuchUser.rawValue)
        }
    }
}
