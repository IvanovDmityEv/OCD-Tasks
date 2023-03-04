//
//  LabelAlertController.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.02.2023.
//

import Foundation
import UIKit

extension UILabel {
    func settingLabel(alertController: UIAlertController, label: UILabel, textLabel: String, font: UIFont, textColor: UIColor, topAnchor: Int) {
        alertController.view.addSubview(label)
        label.font = font
        label.textColor = textColor
        label.text = textLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: CGFloat(topAnchor)).isActive = true
    }
}
