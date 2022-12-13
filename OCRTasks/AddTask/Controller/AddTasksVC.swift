//
//  AddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit

class AddTasksVC: UIViewController {

    
    @IBOutlet weak var nameTasksList: UITextField!
    @IBOutlet weak var switchDate: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchTime: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var buttonAddNewTask: UIButton! {
        didSet {
            buttonAddNewTask.layer.cornerRadius = 7
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func actionAddNewTask(_ sender: UIButton) {
    }

}


extension AddTasksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        
        return cell
    }
}

extension AddTasksVC: UITableViewDelegate { }
