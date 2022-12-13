//
//  CellTask.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit

class CellTask: UITableViewCell {

    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
