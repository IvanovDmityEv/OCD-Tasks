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
    var dateTasks: String? {
        didSet {
            guard dateTasks != nil else  { return }
            buttoAddDate.titleLabel?.text = dateTasks
        }
    }
    var timeTasks: String = " Time"
    private var obsserverCell: Bool = true
//    var cell: CellTask?
    
    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    var tasksList = Array<Tasks>()
    
    @IBOutlet weak var nameTasksList: UITextField!
    
    @IBOutlet weak var stackViewButton: UIStackView! {
        didSet {
            stackViewButton.layer.cornerRadius = 7
        }
    }
    
    
    @IBOutlet weak var buttoAddDate: UIButton! {
        didSet {
            buttoAddDate.layer.cornerRadius = 7
//            buttoAddDate.titleLabel?.text = " Date"
//            guard dateTasks != nil else { return }
//            buttoAddDate.titleLabel?.text = dateTasks
        }
    }
    
    
    @IBOutlet weak var buttonAddTime: UIButton! {
        didSet {
            buttonAddTime.layer.cornerRadius = 7
            buttonAddTime.titleLabel?.text = timeTasks
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
    
    @IBAction func actionAddDate(_ sender: UIButton) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
//        let dateFormater = DateFormatter()
//        if dateTasks != nil {
//            datePicker.date = dateFormater.date(from: dateTasks)
//        }
        
        alertController.view.addSubview(datePicker)
        

        
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        alertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 30).isActive = true

        let save = UIAlertAction(title: "Save", style: .cancel) { [weak self] (action) in
            
            let dateFormater = DateFormatter()
            dateFormater.dateStyle = .short
            self?.dateTasks = dateFormater.string(from: datePicker.date)

            print((self?.dateTasks)!)
            
            
        }
        
        let clear = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            self?.dateTasks = nil
        }
        alertController.addAction(clear)
        alertController.addAction(save)
        
        present(alertController, animated: true)
        
    }
    
    @IBAction func actionAddTime(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        
        alertController.view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        alertController.view.heightAnchor.constraint(equalToConstant: 350).isActive = true

        datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 30).isActive = true

        let save = UIAlertAction(title: "Save", style: .cancel) { [weak self] (action) in
            
            let dateFormater = DateFormatter()
            dateFormater.timeStyle = .short
            self?.timeTasks = dateFormater.string(from: datePicker.date)
            
            print((self?.timeTasks)!)
        }
        
        let clear = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            self?.timeTasks = " Time"
        }
        alertController.addAction(clear)
        alertController.addAction(save)
        
        present(alertController, animated: true)
        
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

