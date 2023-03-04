//
//  CellTasksList.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit

class CellTasksList: UITableViewCell {
    
    var firstShapeLayer: CAShapeLayer!
    var secondShapeLayer: CAShapeLayer!
    
    
        @IBOutlet weak var nameTasksList: UILabel!
        @IBOutlet weak var dateTasks: UILabel!
        @IBOutlet weak var viewTasksList: UIView! {
            didSet {
                let height = viewTasksList.frame.height
                viewTasksList.layer.cornerRadius = height/2
            }
        }
        @IBOutlet weak var countTasks: UILabel!
}
