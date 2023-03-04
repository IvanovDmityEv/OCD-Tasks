//
//  AlertControllerAutorization.swift
//  OCRTasks
//
//  Created by Dmitriy on 06.02.2023.
//

import Foundation
import UIKit

extension AutorizationVC {
    
    func autorizationAlertController(button: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let color = UIColor(displayP3Red: 0.435, green: 0.376, blue: 0.718, alpha: 100)
        alertController.view.tintColor = color
        
        let name = UITextField()
        let titleAlert = UILabel()
        let email = UITextField()
        let password = UITextField()
        let infoText = UILabel()
        
        var textTitleAlert = ""

        if button == signUpButton {
            alertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
            textTitleAlert = "Sign up"
            
            name.settingTextField(alertController: alertController,
                                    textField: name,
                                    image: ImageTextFild.person.rawValue,
                                    textPlaceholder: "Enter your name", bottomAnchor: -220)
            name.autocapitalizationType = .words
            
            alertController.view.addSubview(infoText)
            infoText.numberOfLines = 0
            infoText.text = "We recommend using GMAIL for signing in. The password has to be at least 6 characters."
            infoText.font = UIFont(name: "Avenir Book", size: 10)!
            infoText.widthAnchor.constraint(equalToConstant: 300).isActive = true
            infoText.textAlignment = .center
            infoText.textColor = .darkGray
            infoText.translatesAutoresizingMaskIntoConstraints = false
            infoText.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
            infoText.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 60).isActive = true
            
        } else if button == logInButton {
            alertController.view.heightAnchor.constraint(equalToConstant: 300).isActive = true
            textTitleAlert = "Log in"
        }
        email.autocapitalizationType = .none
        email.textContentType = .emailAddress
        email.settingTextField(alertController: alertController,
                                 textField: email,
                                 image: ImageTextFild.envelope.rawValue,
                                 textPlaceholder: "Enter your email", bottomAnchor: -170)

        
        password.settingTextField(alertController: alertController,
                                    textField: password,
                                    image: ImageTextFild.lock.rawValue,
                                    textPlaceholder: "Enter your passwod",bottomAnchor: -120)
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        
        alertController.view.addSubview(titleAlert)
        titleAlert.font = UIFont(name: "Futura Bold", size: 25)!
        titleAlert.textColor = color
        titleAlert.text = textTitleAlert
        titleAlert.translatesAutoresizingMaskIntoConstraints = false
        titleAlert.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        titleAlert.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 25).isActive = true
        
        
        let actionClose = UIAlertAction(title: "Close", style: .destructive)
        
        let actionOK = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            
            self?.activitiIndicator.hidesWhenStopped = false
            self?.activitiIndicator.startAnimating()
            
            if button == self?.signUpButton {
                self?.signUp(email: email, password: password, name: name)
                
            } else if button == self?.logInButton {
                self?.logIn(email: email, password: password)
            }
        }
        
        alertController.addAction(actionClose)
        alertController.addAction(actionOK)
        
        DispatchQueue.main.async {
              self.present(alertController, animated: true, completion: nil)
          }
    }
    
    func warningAlertController(message: String) {
        activitiIndicator.hidesWhenStopped = true
        activitiIndicator.stopAnimating()
        
        let errorMessage = UIAlertController(title: "Authorization error", message: message, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: "Close", style: .destructive)
        errorMessage.addAction(actionClose)
        
        DispatchQueue.main.async {
              self.present(errorMessage, animated: true, completion: nil)
          }
    }
}
