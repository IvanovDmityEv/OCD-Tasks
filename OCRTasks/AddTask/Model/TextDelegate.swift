//
//  TextDelegate.swift
//  OCRTasks
//
//  Created by Dmitriy on 12.01.2023.
//

import Foundation


protocol TextDelegate: AnyObject {
    func textFromTextFieldCell(textCell text: String, indexCell index: Int)
}
