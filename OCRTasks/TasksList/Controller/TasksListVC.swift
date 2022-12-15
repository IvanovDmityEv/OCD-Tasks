//
//  TasksViewController.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit
import Firebase

class TasksListVC: UIViewController {

private let identifierCell = "CellTasksList"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func userInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueTasksListVC.userInfo.rawValue, sender: nil)
    }
    
    @IBAction func addTasks(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: SegueTasksListVC.addTasks.rawValue, sender: nil)
    }
    
}

extension TasksListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as! CellTasksList
        return cell
    }
}

extension TasksListVC: UITableViewDelegate { }
