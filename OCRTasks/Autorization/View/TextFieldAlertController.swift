//
//  extentionTextFild.swift
//  OCRTasks
//
//  Created by Dmitriy on 29.12.2022.
//

import Foundation
import SwiftUI


extension UITextField {


    func settingTextField(alertController: UIAlertController, textField: UITextField, image: String, textPlaceholder: String, bottomAnchor: Int) {
        alertController.view.addSubview(textField)
        
        textField.borderStyle = .roundedRect
        textField.placeholder = textPlaceholder
        textField.settingImageTextFild(image: image)
        textField.font = UIFont(name: "Avenir Book", size: 15)
        textField.autocorrectionType = .no
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: CGFloat(bottomAnchor)).isActive = true
        
    }
    
    func settingImageTextFild(image: String) {
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 24, height: 18))
        let image = UIImage(systemName: image)
        imageView.image = image
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 18))
        imageContainerView.addSubview(imageView)
        leftViewMode = .always
        leftView = imageContainerView
        self.tintColor = .systemGray4
    }
}
