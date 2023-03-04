//
//  TableViewAddTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.02.2023.
//

import Foundation
import UIKit

extension AddTasksVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return yourTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAddTask", for: indexPath) as! CellAddTasks
        
        cell.delegate = self
        
        cell.indexCell = indexPath.row

        if editableTasksList.tasks != [] {
            cell.newTaskTextField.text = yourTasks[indexPath.row]
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        deleteCell(indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deleteCell(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in

            self?.tableView.endEditing(true)
            self?.yourTasks.removeLast()
            
            self?.dictionaryTasks.removeValue(forKey: indexPath.row)
            self?.dictionariCoppleted.removeValue(forKey: indexPath.row)
            self?.dictionaryPhoto.removeValue(forKey: indexPath.row)
            
            self?.dictionaryTasks = self?.updateDictionary(dictionary: self!.dictionaryTasks, indexPath: indexPath) as! [Int: String]
            self?.dictionariCoppleted = self?.updateDictionary(dictionary: self!.dictionariCoppleted, indexPath: indexPath) as! [Int: Bool]
            self?.dictionaryPhoto = self?.updateDictionary(dictionary: self!.dictionaryPhoto, indexPath: indexPath) as! [Int: [String]]
            
            self?.tableView.beginUpdates()
            self?.tableView.deleteRows(at: [indexPath], with: .right)
            self?.tableView.endUpdates()
        }
        let deleteAction = UISwipeActionsConfiguration(actions: [action])

        return deleteAction
    }
    
    func updateDictionary(dictionary: [Int: Any], indexPath: IndexPath) -> [AnyHashable : Any] {
        let newDictionary = dictionary.reduce(into: [:]) { new, old in
            
            if old.key > indexPath.row {
                let newKey = Int(old.key - 1)
                new[newKey] = old.value
            } else {
                let newKey = Int(old.key)
                new[newKey] = old.value
            }
        }
        return newDictionary
    }
}
