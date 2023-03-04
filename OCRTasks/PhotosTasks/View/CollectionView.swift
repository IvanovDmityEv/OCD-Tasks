//
//  CollectionView.swift
//  OCRTasks
//
//  Created by Dmitriy on 07.02.2023.
//

import Foundation
import UIKit

extension PhotosTasksVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell

        cell.photo.image = arrayPhotos[indexPath.row]
        cell.layer.cornerRadius = 5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto.image = arrayPhotos[indexPath.row]
        indexSelectedPhoto = indexPath.row
    }
}
