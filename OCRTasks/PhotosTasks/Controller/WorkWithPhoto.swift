//
//  WorkWithPhoto.swift
//  OCRTasks
//
//  Created by Dmitriy on 14.02.2023.
//

import Foundation
import FirebaseStorage
import UIKit


extension PhotosTasksVC {
    
    func uploadPhoto() {
        arrayUrl = []
        activitiIndicator.hidesWhenStopped = false
        activitiIndicator.startAnimating()
        guard let currentTask = currentTask else { return }
        
        let ref = Storage.storage().reference().child("photoTasks").child(user.uid).child(currentTaskList.title).child(currentTask)
        
        if arrayPhotos != [] {
            var i = 0
                for photo in self.arrayPhotos {
                    let refPhoto = ref.child("photo-\(i)")
                    i += 1
                    guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    
                    refPhoto.putData(imageData, metadata: metadata) { metadata, error in
                        guard let _ = metadata else {
                            return
                        }
                        refPhoto.downloadURL { [weak self] url, error in
                            guard let url = url else {
                                return
                            }
                            self?.arrayUrl.append(url.absoluteString)

                            if self?.arrayUrl.count == self?.arrayPhotos.count {
                                var photosTasks = self?.currentTaskList.photosTasks
                                
                                guard self?.indexCurrentTasks != nil else { return }
                                photosTasks![((self?.indexCurrentTasks)!)] = (self?.arrayUrl)!

                                self?.currentTaskList.photosTasks![((self?.indexCurrentTasks)!)] = (self?.arrayUrl)!

                                self?.currentTaskList.ref?.updateChildValues(["photosTasks": photosTasks!])
                                
                                self?.activitiIndicator.hidesWhenStopped = true
                                self?.activitiIndicator.stopAnimating()
                                
                                self?.performSegue(withIdentifier: "unwindSegueToTasksVC", sender: nil)
                            }
                        }
                    }
                }
        } else {
            var photosTasks = self.currentTaskList.photosTasks
            guard self.indexCurrentTasks != nil else { return }
            photosTasks![((self.indexCurrentTasks)!)] = [""]
            self.currentTaskList.photosTasks![((self.indexCurrentTasks)!)] = [""]

            self.currentTaskList.ref?.updateChildValues(["photosTasks": photosTasks!])
            
            self.activitiIndicator.hidesWhenStopped = true
            self.activitiIndicator.stopAnimating()
            
            self.performSegue(withIdentifier: "unwindSegueToTasksVC", sender: nil)
        }

    }
    
    func downloadPhotoWithFirebase() {
        arrayPhotos = []
        guard let photosTasks = currentTaskList.photosTasks, photosTasks[indexCurrentTasks!] != [""] else { return }
        
        activitiIndicator.hidesWhenStopped = false
        activitiIndicator.startAnimating()
        
        arrayUrl = photosTasks[indexCurrentTasks!]
        
        for url in arrayUrl {
            let ref = Storage.storage().reference(forURL: url)
            let megaBite = Int64(10*1024*1024)
            ref.getData(maxSize: megaBite) { [weak self] data, error in
                guard let imageData = data else {
                    return
                }
                let photo = UIImage(data: imageData)
                self?.arrayPhotos.append(photo!)
                
                if self?.arrayUrl.count == self?.arrayPhotos.count {
                    self?.photoCollectionView.reloadData()
                    self?.activitiIndicator.hidesWhenStopped = true
                    self?.activitiIndicator.stopAnimating()
                }
            }
        }
    }
    
    func addCheckmark() {
        
        var completed = self.currentTaskList.completed
        
        var title = ""
        if self.currentTaskList.completed![self.indexCurrentTasks!] == true {
            title = "Isn't task completed?"
        } else {
            title = "Is the task completed?"
        }
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let color = UIColor(displayP3Red: 0.435, green: 0.376, blue: 0.718, alpha: 100)
        alertController.view.tintColor = color
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self]_ in
            
            let isComplition = !completed![(self?.indexCurrentTasks!)!]
            completed![(self?.indexCurrentTasks!)!] = isComplition

            self?.currentTaskList.completed = completed
            self?.currentTaskList.ref?.updateChildValues(["completed": completed as Any])
            
            self?.uploadPhoto()
        }
        let noAction = UIAlertAction(title: "No", style: .destructive)
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        present(alertController, animated: true)
    }
}
