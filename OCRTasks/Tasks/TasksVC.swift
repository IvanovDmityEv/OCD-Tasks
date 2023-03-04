//
//  TasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 10.01.2023.
//

import UIKit
import Firebase

class TasksVC: UIViewController {
    
    var currentTaskList = TasksList(title: "", tasks: [], dateTasks: "", timeTasks: "", completed: [], photosTasks: [], userId: "")
    
    var firstShapeLayerTasks: CAShapeLayer!{
        didSet {
            settingViewFirstShapeLayerTasks()
        }
    }
    var secondShapeLayerTasks: CAShapeLayer!{
        didSet {
            settingViewSecondShapeLayerTasks()
        }
    }
    var completedForShapelayer: Float!
    
    
    @IBOutlet weak var nameTaskList: UILabel! {
        didSet {
            nameTaskList.text = currentTaskList.title
        }
    }
    @IBOutlet weak var dateTaskList: UILabel! {
        didSet {
            dateTaskList.text = "\(currentTaskList.dateTasks ?? "")\(currentTaskList.timeTasks ?? "")"
        }
    }

    @IBOutlet weak var viewTasksVC: UIView! {
        didSet {
            let height = viewTasksVC.frame.height
            viewTasksVC.layer.cornerRadius = height/2
        }
    }
    @IBOutlet weak var countTasks: UILabel!
    
    @IBOutlet weak var tableViewTasksVC: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstShapeLayerTasks = CAShapeLayer()
        view.layer.addSublayer(firstShapeLayerTasks)
        
        secondShapeLayerTasks = CAShapeLayer()
        view.layer.addSublayer(secondShapeLayerTasks)
        completingTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        completingTasks()
    }
    
    override func viewDidLayoutSubviews() {
        settingShapeLayer(firstShapeLayerTasks)
        settingShapeLayer(secondShapeLayerTasks)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueTasksVC.addPhoto.rawValue {

            guard let indexPath = tableViewTasksVC.indexPathForSelectedRow else { return }
            
            let photoTasksVC = segue.destination as! PhotosTasksVC
            photoTasksVC.currentTaskList = currentTaskList
            
            photoTasksVC.currentTask = currentTaskList.tasks[indexPath.row]
            photoTasksVC.indexCurrentTasks = indexPath.row
        }
        
        if segue.identifier == SegueTasksVC.editTask.rawValue {

            let addTasksVC = segue.destination as! AddTasksVC
            
            addTasksVC.editableTasksList = currentTaskList
        }
    }
    
    
    
    func completingTasks() {
        var completedTasks = 0
        if currentTaskList.completed != nil{
            for i in currentTaskList.completed! {
                if i == true {
                    completedTasks += 1
                }
            }
            countTasks.text = "\(completedTasks)/\(currentTaskList.completed!.count)"
            
            completedForShapelayer = Float(completedTasks)/(Float(currentTaskList.completed!.count))
            secondShapeLayerTasks.strokeEnd = CGFloat(completedForShapelayer)
        } else {
            countTasks.text = "no tasks"
            secondShapeLayerTasks.strokeEnd = 1
        }
    }
    
    @IBAction func editTasksUnwindSegueToTasksVC(segue: UIStoryboardSegue) {
        guard segue.identifier == SegueTasksVC.editTasksUnwindSegueToTasksVC.rawValue else { return }
        let addTasksVC = segue.source as? AddTasksVC
        currentTaskList = addTasksVC!.editableTasksList
        dateTaskList.text = addTasksVC!.dateTasks.text
        tableViewTasksVC.reloadData()
    }
    
    
    @IBAction func unwindSegueToTasksVC(segue: UIStoryboardSegue) {
        guard segue.identifier == SegueTasksVC.unwindSegueToTasksVC.rawValue else { return }
        
        let photoTasksVC = segue.source as? PhotosTasksVC
        currentTaskList = photoTasksVC!.currentTaskList
        tableViewTasksVC.reloadData()
    }
}


