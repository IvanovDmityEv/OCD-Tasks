//
//  WorkWithPhoto.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.02.2023.
//

import Foundation
import PhotosUI

extension PhotosTasksVC: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    self.arrayPhotos.append(image)
                }
                
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                    self.savePhotoButton.isEnabled = true
                }
            }
        }
    }
    
    func pickerPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        
        let pickerVC = PHPickerViewController(configuration: configuration)
        pickerVC.delegate = self
        self.present(pickerVC, animated: true)
    }
}

extension PhotosTasksVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        
        guard let newPhoto = (info[.originalImage] as? UIImage) else { return }
        self.arrayPhotos.append(newPhoto)
        
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
            self.savePhotoButton.isEnabled = true
        }
    }
    
    func pickerPhotoCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
}
