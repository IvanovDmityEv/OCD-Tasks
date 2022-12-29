//
//  extentionTextFild.swift
//  OCRTasks
//
//  Created by Dmitriy on 29.12.2022.
//

import Foundation
import SwiftUI


extension UITextField {

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
