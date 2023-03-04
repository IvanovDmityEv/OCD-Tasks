//
//  WorkWithTableView.swift
//  OCRTasks
//
//  Created by Dmitriy on 01.02.2023.
//

import Foundation
import UIKit


extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentTaskList.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTask", for: indexPath) as! CellTasks
        
        cell.textTasks.text = currentTaskList.tasks[indexPath.row]
        if currentTaskList.completed![indexPath.row] == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
