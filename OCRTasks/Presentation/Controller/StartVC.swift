//
//  StartVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 05.12.2022.
//

import UIKit

class StartVC: UIViewController {
    
    var imagePrezent: String?
    var textPrezent: String?
    var currentPage = 0
    var numberOfPages = 0
    var lastPage = 0

    @IBOutlet weak var imageStartVC: UIImageView! {
        didSet {
            imageStartVC.layer.cornerRadius = 20
            imageStartVC.layer.borderWidth = 1
            imageStartVC.layer.borderColor = .init(red: 0.682, green: 0.682, blue: 0.698, alpha: 100)
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
    @IBOutlet weak var buttonCloseStartVC: UIButton! {
        didSet {
            let height = buttonCloseStartVC.frame.height
            buttonCloseStartVC.layer.cornerRadius = height/2
            buttonCloseStartVC.isHidden = true
            
            if currentPage == lastPage {
                buttonCloseStartVC.isHidden = false
            }
        }
    }
    
    @IBAction func closeStartVC(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
