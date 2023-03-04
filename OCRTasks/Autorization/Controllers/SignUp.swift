//
//  SignUp.swift
//  OCRTasks
//
//  Created by Dmitriy on 06.02.2023.
//

import Foundation
import Firebase
import FirebaseDatabase
//import FirebaseAuth

extension AutorizationVC {
    
    func signUp(email: UITextField, password: UITextField, name: UITextField) {
        
        guard let email = email.text,
            let password = password.text,
            let userName = name.text,
            email != "",
            password != "",
            userName != "" else {
            warningAlertController(message: Messages.infoIsIncorrect.rawValue)

            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in

            if error == nil {
                if user != nil {

                    let newUser = User(uid: (user?.user.uid)!, email: (user?.user.email)!, displayName: userName)
                    let userRef = self?.ref.child(newUser.uid)
                    userRef?.setValue(["email": newUser.email, "displayName": newUser.displayName])

                } else {
                    self?.warningAlertController(message: Messages.errorOccurred.rawValue)
                }
            } else {
                self?.warningAlertController(message: Messages.infoIsIncorrect.rawValue)
            }
        }
    }
}

