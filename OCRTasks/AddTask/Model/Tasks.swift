//
//  Tasks.swift
//  OCRTasks
//
//  Created by Dmitriy on 19.12.2022.
//

import Foundation
import Firebase

struct Tasks {
    let title: String
    let tasks: [String?]
    let dateTasks: String?
    let timeTasks: String?
    let userId: String
    let ref: DatabaseReference?
    var completed: Bool = false
    
    init(title: String, tasks: [String?], dateTasks: String?, timeTasks: String?, userId: String) {
        self.title = title
        self.tasks = tasks
        self.dateTasks = dateTasks
        self.timeTasks = timeTasks
        self.userId = userId
        self.ref = nil
    }
    //срез данных на данный момент
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        tasks = snapshotValue["tasks"] as! [String]
        dateTasks = snapshotValue["dateTasks"] as! String?
        timeTasks = snapshotValue["timeTasks"] as! String?
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
