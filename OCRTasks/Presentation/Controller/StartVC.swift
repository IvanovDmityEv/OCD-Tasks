//
//  StartVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 05.12.2022.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var imageStartVC: UIImageView! {
        didSet {
            imageStartVC.image = UIImage(named: imagePrezent!) //подумать
        }
    }
    @IBOutlet weak var textStartVC: UILabel! {
        didSet {
            textStartVC.text = textPrezent
        }
    }
    @IBOutlet weak var pageControlStartVC: UIPageControl! {
        didSet {
            pageControlStartVC.numberOfPages = numberOfPages
            pageControlStartVC.currentPage = currentPage
        }
    }
    @IBOutlet weak var closeStartVC: UIButton! {
        didSet {
            let height = closeStartVC.frame.height
            closeStartVC.layer.cornerRadius = height/2
            closeStartVC.isHidden = true
            
            if currentPage == lastPage {
                closeStartVC.isHidden = false
            }
        }
    }
    
    var imagePrezent: String?
    var textPrezent: String?
    var currentPage = 0
    var numberOfPages = 0
    var lastPage = 0
    
    
    @IBAction func buttonCloseStartVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
}