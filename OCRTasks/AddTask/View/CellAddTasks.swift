//
//  CellTask.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit

class CellAddTasks: UITableViewCell {

    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    var indexCell: Int!
    
    weak var delegate: TextDelegate? //для моего делегата
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        newTaskTextField.delegate = self
    }
}

extension CellAddTasks: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = newTaskTextField.text else { return }
        self.delegate?.textFromTextFieldCell(textCell: text, indexCell: indexCell)
        
    }
    
    //скрытие клавиатуры по нажатию Done
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTaskTextField.resignFirstResponder()        
        return true
    }
}
