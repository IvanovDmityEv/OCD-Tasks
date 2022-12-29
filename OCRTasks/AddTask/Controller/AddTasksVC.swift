//
//  AddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit
import Firebase

class AddTasksVC: UIViewController {

    var arrayTasks: [String?] = []
    private var tap: [String] = []
    private var date: Date?
    var dateString: String? {
        didSet {
            guard let dateString = dateString else { return }
            dateTasks.text! = "\(dateString) \(timeString ?? "")"
        }
    }
    
    private var time: Date?
    var timeString: String? {
        didSet {
            guard let timeString = timeString else { return }
            dateTasks.text! = "\(dateString ?? "") \(timeString)"
        }
    }
    
//    private var obsserverCell: Bool = true
//    var cell: CellTask?
    
    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    var tasksList = Array<Tasks>()
    
    
    
    @IBOutlet weak var dateTasks: UILabel!
    
    @IBOutlet weak var nameTasksList: UITextField!
    
    @IBOutlet weak var stackViewButton: UIStackView! {
        didSet {
            stackViewButton.layer.cornerRadius = 7
        }
    }
    
    @IBOutlet weak var buttonAddDate: UIButton! {
        didSet {
            buttonAddDate.layer.cornerRadius = 7
        }
    }
    
    @IBOutlet weak var buttonAddTime: UIButton! {
        didSet {
            buttonAddTime.layer.cornerRadius = 7
        }
    }
    
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
        
        guard let currentUser = Auth.auth().currentUser else { return }

        user.uid = currentUser.uid
        user.displayName = currentUser.displayName ?? ""
        user.email = currentUser.email!

        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasksList")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func actionAddDate(_ sender: UIButton) {

        let dateAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        dateAlertController.view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        dateAlertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        datePicker.centerXAnchor.constraint(equalTo: dateAlertController.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: dateAlertController.view.topAnchor, constant: 30).isActive = true
    
        if date != nil {
            datePicker.date = date!
        }
        
        let clearDate = UIAlertAction(title: "Clear", style: .default) { [weak self] (action) in
            self?.date = nil
            self?.dateString = nil
            guard let timeString = self?.timeString else {
                self?.dateTasks.text = ""
                return
            }
            self?.dateTasks.text = timeString
        }
        
        let saveDate = UIAlertAction(title: "Save", style: .default) { [weak self] (action) in
            
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = .medium
            
            self?.dateString = dateFormater.string(from: datePicker.date)
            self?.date = datePicker.date

        }
        dateAlertController.addAction(clearDate)
        dateAlertController.addAction(saveDate)
        
        present(dateAlertController, animated: true)
        
    }
    
    @IBAction func actionAddTime(_ sender: UIButton) {
        
        let timeAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let timePicker = UIDatePicker()
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.datePickerMode = .time
        
        timeAlertController.view.addSubview(timePicker)
        
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        timeAlertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        timePicker.centerXAnchor.constraint(equalTo: timeAlertController.view.centerXAnchor).isActive = true
        timePicker.topAnchor.constraint(equalTo: timeAlertController.view.topAnchor, constant: 30).isActive = true
    
        if time != nil {
            timePicker.date = time!
        }
        
        let clearTime = UIAlertAction(title: "Clear", style: .default) { [weak self] (action) in
            self?.time = nil
            self?.timeString = nil
            guard let dateString = self?.dateString else {
                self?.dateTasks.text = ""
                return
            }
            self?.dateTasks.text = dateString
        }
        
        let saveTime = UIAlertAction(title: "Save", style: .default) { [weak self] (action) in
            
            let dateFormater = DateFormatter()
            dateFormater.timeStyle = .short
            
            self?.timeString = dateFormater.string(from: timePicker.date)
            self?.time = timePicker.date
            
//            let date = self?.date
//            self?.date = date
//
//            let dateString = self?.dateString
//            self?.dateString = dateString
//
        }
        timeAlertController.addAction(clearTime)
        timeAlertController.addAction(saveTime)
        
        present(timeAlertController, animated: true)
        
    }
    
    @IBAction func actionAddNewTask(_ sender: UIButton) {
        let indexPath = IndexPath(row: tap.count, section: 0)
                tap.append("tap \(tap.count)")
                tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
                tableView.endUpdates()

    }
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        
        guard let nameTaskList = nameTasksList, nameTaskList.text != "" else { return }
        
        let tasksList = Tasks(title: nameTasksList.text!, tasks: arrayTasks, dateTasks: dateString, timeTasks: timeString, userId: self.user.uid)
//        let taskRef = self.ref.child(tasksList.title.lowercased()).child(tasksList.dateTasks ?? "note date").child(tasksList.timeTasks ?? "note time")
        let taskRef = self.ref.child(tasksList.title.lowercased())
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        
        guard let textTask = cell.newTaskTextField, textTask.text != "" else { return }
        arrayTasks.append(textTask.text!)
        tableView.reloadData()
            print(textTask.text!)
                
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTask
        
        guard let textTask = cell.newTaskTextField, textTask.text != "" else { return }
            arrayTasks.append(textTask.text!)
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
