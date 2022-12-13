//
//  CellTasksList.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit

class CellTasksList: UITableViewCell {
    
        @IBOutlet weak var nameTasksList: UILabel!
        @IBOutlet weak var dateTasks: UILabel!
        @IBOutlet weak var viewTasksList: UIView! {
            didSet {
                let height = viewTasksList.frame.height
                viewTasksList.layer.cornerRadius = height/2
            }
        }
        @IBOutlet weak var countTasks: UILabel!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
