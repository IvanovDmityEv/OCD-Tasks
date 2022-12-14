//
//  TasksViewController.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit
import Firebase

class TasksListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
}

extension TasksListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTasksList", for: indexPath) as! CellTasksList
        
        return cell
    }
}

extension TasksListVC: UITableViewDelegate { }
