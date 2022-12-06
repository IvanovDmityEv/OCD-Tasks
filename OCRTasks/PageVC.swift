//
//  PageVCViewController.swift
//  OCRTasks
//
//  Created by Dmitriy on 05.12.2022.
//

import UIKit

class PageVC: UIPageViewController {
    let arrayPresentNameImage = ["image1", "image2", "image3"]
    let arrayPresentText = ["Do you have OCD?",
                            "Do you double-check your tasks?",
                            "This app will make your life a little easier"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let startVC = showViewController(0) {
            setViewControllers([startVC], direction: .forward, animated: true)
        }
    }
    
    func showViewController(_ index: Int) -> StartVC? { //наполняем StartVC
        guard index >= 0 else { return nil }
        guard index < arrayPresentText.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "presentationWasViewed2")
            return nil}
        guard let startVC = storyboard?.instantiateViewController(withIdentifier: "StartVC") as? StartVC else { return nil}
        startVC.imagePrezent = arrayPresentNameImage[index]
        startVC.textPrezent = arrayPresentText[index]
        startVC.currentPage = index
        startVC.numberOfPages = arrayPresentText.count
        startVC.lastPage = arrayPresentText.endIndex - 1
        return startVC
    }
}

extension PageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! StartVC).currentPage
        pageNumber -= 1
        return showViewController(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! StartVC).currentPage
        pageNumber += 1
        return showViewController(pageNumber)
    }
}


