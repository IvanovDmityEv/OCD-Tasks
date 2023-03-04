//
//  PhotosTasksVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.02.2023.
//

import UIKit
import PhotosUI
import Firebase
import FirebaseStorage

class PhotosTasksVC: UIViewController {

    var arrayPhotos = [UIImage]() {
        didSet {
            if arrayPhotos.count != 0 {
                DispatchQueue.main.async { [weak self] in
                    self?.selectedPhoto.image = (self?.arrayPhotos.first)!
                    self?.indexSelectedPhoto = 0
                    self?.deleteSelectedPhoto.isHidden = false
                }
            } else {
                selectedPhoto.image = UIImage(named: "image-photo")
                deleteSelectedPhoto.isHidden = true
            }
        }
    }
    
    var user = User(uid: "", email: "", displayName: "")
    var currentTaskList = TasksList(title: "", tasks: [], dateTasks: "", timeTasks: "", completed: [], photosTasks: [], userId: "")
    var currentTask: String?
    var indexCurrentTasks: Int?
    var arrayUrl: [String] = []
    var indexSelectedPhoto: Int?
    
    
    @IBOutlet weak var selectedPhoto: UIImageView! {
        didSet {
            selectedPhoto.layer.cornerRadius = 45/2
        }
    }
    
    @IBOutlet weak var taskText: UILabel! {
        didSet {
            taskText.text = "Task: \(currentTask!)"
        }
    }
    
    @IBOutlet weak var photoCameraButton: UIButton! {
        didSet {
            let height = photoCameraButton.frame.height
            photoCameraButton.layer.cornerRadius = height/2
        }
    }
    
    @IBOutlet weak var photoLibraryButton: UIButton! {
        didSet {
            let height = photoLibraryButton.frame.height
            photoLibraryButton.layer.cornerRadius = height/2
        }
    }
    
    @IBOutlet weak var checkmarkButton: UIButton! {
        didSet {
            let height = checkmarkButton.frame.height
            checkmarkButton.layer.cornerRadius = height/2
        }
    }
    
    @IBOutlet weak var deleteSelectedPhoto: UIButton! {
            didSet {
                deleteSelectedPhoto.isHidden = true
                let height = deleteSelectedPhoto.frame.height
                deleteSelectedPhoto.layer.cornerRadius = height/2
            }
    }
    
    
    @IBOutlet weak var savePhotoButton: UIBarButtonItem! {
        didSet {
            savePhotoButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView! {
        didSet {
            activitiIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let currentUser = Auth.auth().currentUser else { return }
        
        user.uid = currentUser.uid
        user.displayName = currentUser.displayName ?? ""
        user.email = currentUser.email!
        downloadPhotoWithFirebase()
        
        photoCollectionView.delegate = self
    }
    
    @IBAction func savePhoto(_ sender: UIBarButtonItem) {
        uploadPhoto()
    }
    
    @IBAction func photoCameraAction(_ sender: UIButton) {
        pickerPhotoCamera()
    }
    
    @IBAction func photoLibraryAction(_ sender: Any) {
        pickerPhotoLibrary()
    }
    
    @IBAction func checkmarkAction(_ sender: UIButton) {
        addCheckmark()
    }
    
    @IBAction func deleteSelectedPhotoAction(_ sender: UIButton) {
        if indexSelectedPhoto == 0 {
            arrayPhotos.removeFirst()
        } else {
            arrayPhotos.remove(at: indexSelectedPhoto!)
        }
        photoCollectionView.reloadData()
        savePhotoButton.isEnabled = true
    }
}
