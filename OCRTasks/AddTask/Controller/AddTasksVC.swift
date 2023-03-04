//
//  AddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class AddTasksVC: UIViewController {
    
    var dictionaryTasks: [Int: String] = [:]
    var dictionariCoppleted: [Int:Bool] = [:]
    var dictionaryPhoto: [Int:[String]] = [:]
    
    var yourTasks: [String?] = []
    
    var dateString: String? {
        didSet {
            guard let dateString = dateString else { return }
            dateTasks.text! = "\(dateString)\(timeString ?? "")"
        }
    }
    
    var timeString: String? {
        didSet {
            guard let timeString = timeString else { return }
            dateTasks.text! = "\(dateString ?? "")\(timeString)"
        }
    }
    
    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    var tasksList = Array<TasksList>()
    
    var editableTasksList = TasksList(title: "", tasks: [], dateTasks: "", timeTasks: "", completed: [], photosTasks: [], userId: "") {
        didSet {
            if editableTasksList.tasks != [] {
                var i = 0
                for task in editableTasksList.tasks {
                    dictionaryTasks[i] = task
                    i += 1
                }
            }
            if editableTasksList.completed != nil {
                var i = 0
                for completed in editableTasksList.completed! {
                    dictionariCoppleted[i] = completed
                    i += 1
                }
            }
            if editableTasksList.photosTasks != nil {
                var i = 0
                for photo in editableTasksList.photosTasks! {
                    dictionaryPhoto[i] = photo
                    i += 1
                }
            }
        }
    }
    
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

    @IBOutlet weak var buttonSave: UIBarButtonItem! {
        didSet {
            buttonSave.isEnabled = false
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        nameTasksList.delegate = self
        
        observerKeyboard()
        nameTasksList.addTarget(self, action: #selector(UITextFieldDelegate.textFieldDidChangeSelection(_:)), for: UIControl.Event.editingChanged)
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user.uid = currentUser.uid
        user.email = currentUser.email!

        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasksList")
        
        fillView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func fillView() {
        if editableTasksList.title != "" {
            nameTasksList.text = editableTasksList.title
            nameTasksList.isEnabled = false
            buttonSave.isEnabled = true
        }
        if editableTasksList.dateTasks != "" {
            dateString = editableTasksList.dateTasks
        }
        if editableTasksList.timeTasks != "" {
            timeString = editableTasksList.timeTasks
        }
        if editableTasksList.tasks != [] {
            yourTasks = (editableTasksList.tasks)
        }
    }

    @IBAction func actionAddDate(_ sender: UIButton) {
        showAlertController(datePickerMode: .date)
    }
    
    @IBAction func actionAddTime(_ sender: UIButton) {
        showAlertController(datePickerMode: .time)
    }
    
    @IBAction func actionAddNewTask(_ sender: UIButton) {
        let indexPath = IndexPath(row: yourTasks.count, section: 0)
        yourTasks.append("")
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
    @IBAction func saveTasks(_ sender: UIBarButtonItem) {
        saveTasks()
    }
    
    func saveTasks() {
        self.view.endEditing(true)
        
        var arrayTasks: [String?] = []
        var taskText: String?
        var arrayCompleted: [Bool] = []
        var arrayPhotos: [[String]] = []
        
        if dictionaryTasks != [:] {
            for key in 0...dictionaryTasks.keys.max()! {
                taskText = dictionaryTasks[key]
                if taskText != nil, taskText != "" {
                    arrayTasks.append(taskText)
                }
            }
        }
        
        if editableTasksList.tasks != [] {
            
            if dictionariCoppleted != [:] {
                for key in 0...dictionariCoppleted.keys.max()! {
                    let completed = dictionariCoppleted[key]
                    if dictionaryTasks[key] != nil, dictionaryTasks[key] != "" {
                        arrayCompleted.append(completed!)
                    }
                }
            }
            
            if dictionaryPhoto != [:] {
                for key in 0...dictionaryPhoto.keys.max()! {
                    let photo = dictionaryPhoto[key]
                    if dictionaryTasks[key] != nil, dictionaryTasks[key] != "" {
                        arrayPhotos.append(photo!)
                    }
                }
            }
            
        } else {
            
            arrayCompleted = Array(repeating: false, count: arrayTasks.count)
            arrayPhotos = Array(repeating: [""], count: arrayTasks.count)
        }
        
        guard let nameTaskList = nameTasksList, nameTaskList.text != "" else { return }
        
        let tasksList = TasksList(title: nameTaskList.text!, tasks: arrayTasks, dateTasks: dateString, timeTasks: timeString, completed: arrayCompleted, photosTasks: arrayPhotos, userId: self.user.uid)
        
        
        let taskRef = self.ref.child(tasksList.title.lowercased())
        
        taskRef.setValue(tasksList.convertDictionary())
        
        if editableTasksList.title != "" {
            deletePhotoTasks(tasksList: tasksList)
            editableTasksList = tasksList
            performSegue(withIdentifier: SegueAddTasksVC.editTasksUnwindSegueToTasksVC.rawValue, sender: nil)
        } else {
            performSegue(withIdentifier: SegueAddTasksVC.unwindSegueToTasksListVC.rawValue, sender: nil)
        }
    }
    
    func deletePhotoTasks(tasksList: TasksList) {
        
        let refStorage = Storage.storage().reference()
        for task in editableTasksList.tasks {
            if !tasksList.tasks.contains(task) {
                let photoRef = refStorage.child("photoTasks").child(user.uid).child(editableTasksList.title).child(task!)
                photoRef.listAll { result, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    for file in result!.items {
                        file.delete { error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print("file deleted")
                            }
                        }
                    }
                }
                photoRef.delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("photos deleted")
                    }
                }
            }
        }
    }
}

extension AddTasksVC: TextDelegate {
    func textFromTextFieldCell(textCell text: String, indexCell index: Int) {
        dictionaryTasks[index] = text
        if !editableTasksList.tasks.contains(text) {
            dictionariCoppleted[index] = false
            dictionaryPhoto[index] = [""]
        }
    }
}
