//
//  AddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit
import Firebase

class AddTasksVC: UIViewController {

    var arrayTasks: [String] = []
    var tap: [String] = []
    private var obsserverCell: Bool = true
//    var cell: CellTask?
    
    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    var tasksList = Array<Tasks>()
    
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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        nameTasksList.delegate = self
        
//        guard let currentUser = Auth.auth().currentUser else { return }
//
//        user.uid = currentUser.uid
//        user.displayName = currentUser.displayName ?? ""
//        user.email = currentUser.email!
//
//        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasksList")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

    @IBAction func actionAddNewTask(_ sender: UIButton) {
//        countTap += 1
//        tableView.reloadData()
        let indexPath = IndexPath(row: tap.count, section: 0)
                tap.append("tap \(tap.count)")
                tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
                tableView.endUpdates()

    }
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        
        guard let nameTaskList = nameTasksList, nameTaskList.text != "" else { return }
        
//        let tasks = Tasks(title: nameTaskList.text!, tasks: arrayTasks, dateTasks: <#T##Date?#>, timeTasks: <#T##Date?#>, userId: <#T##String#>)
    }
}

extension AddTasksVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        if arrayTasks.count != 0 {
            cell.newTaskTextField.text = arrayTasks[indexPath.row]

        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
//        if cell.newTaskTextField.text != "" {
//            obsserverCell = false
//        }
//        return indexPath
//    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
//
//                arrayTasks.append(textTask.text!)
//                tableView.reloadData()
//                print("кол-во элементов: \(arrayTasks.count)")
        
//        if obsserverCell == true {
//            arrayTasks.append(textTask.text!)
//            tableView.reloadData()
//            printContent("кол-во элементов: \(arrayTasks.count)")
//        } else {
//            arrayTasks.insert(textTask.text!, at: 0)
//            tableView.reloadData()
//
        
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        
        guard let textTask = cell.newTaskTextField, textTask.text != "" else { return }
                    obsserverCell = false
        arrayTasks.append(textTask.text!)
        tableView.reloadData()
            print(textTask.text!)
                
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        
        guard let textTask = cell.newTaskTextField, textTask.text != "" else { return }
            arrayTasks.append(textTask.text!)
    print("массив: \(arrayTasks)")
            tableView.reloadData()
    }
    
}


extension AddTasksVC: UITextFieldDelegate {
    
    //скрытие клавиатуры по нажатию Done
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTasksList.resignFirstResponder()
        return true
    }
}

