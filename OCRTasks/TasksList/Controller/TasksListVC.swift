//
//  TasksViewController.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit
import Firebase

class TasksListVC: UIViewController {
    
    let identifierCell = "CellTasksList"
    
    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    var tasksListF = Array<TasksList>()
    
    @IBOutlet weak var tableViewTasksList: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        user.uid = currentUser.uid
        user.displayName = currentUser.displayName ?? ""
        user.email = currentUser.email!
        
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasksList")
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { [weak self] snapshot in
            var _tasksList = Array<TasksList>()
            for item in snapshot.children {
                let tasks = TasksList(snapshot: item as! DataSnapshot)
                _tasksList.append(tasks)
            }
            self?.tasksListF = _tasksList
            
            self?.tableViewTasksList.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueTasksListVC.showTasks.rawValue {
            guard let indexPath = tableViewTasksList.indexPathForSelectedRow else { return }
            
            let tasksVC = segue.destination as! TasksVC
            
            tasksVC.currentTaskList = tasksListF[indexPath.row]
        }
    }
    
    @objc func updateProgressView() {
        if progressView.progress != 1 {
            self.progressView.progress += 0.01
        } else {
            self.progressView.isHidden = true
        }
    }
    
    @IBAction func userInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueTasksListVC.userInfo.rawValue, sender: nil)
    }
    
    @IBAction func addTasks(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueTasksListVC.addTasks.rawValue, sender: nil)
    }
    
    @IBAction func unwindSegueToTasksListVC(segue: UIStoryboardSegue) {
        guard segue.identifier == SegueTasksListVC.unwindSegueToTasksListVC.rawValue else { return }
        
    }
}
