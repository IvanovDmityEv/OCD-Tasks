//
//  PageVCViewController.swift
//  OCRTasks
//
//  Created by Dmitriy on 05.12.2022.
//

import UIKit

class PageVC: UIPageViewController {
    let arrayPresentNameImage = ["image-prezentation-1",
                                 "image-prezentation-2",
                                 "image-prezentation-3",
                                 "image-prezentation-4"]
    let arrayPresentText = ["If you always worry about “Did I switch smth off?”, you are in right place.",
                            "You can create list of tasks, add photo and check yourself later.",
                            "Our app will help you don’t concern about it.",
                            "We understand and care of you!"]
    
    private let identifireStartVC = "StartVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let startVC = self.showViewController(0) {
            setViewControllers([startVC], direction: .forward, animated: true)
        }
    }
    
    func showViewController(_ index: Int) -> StartVC? { //наполняем StartVC
        guard index >= 0 else { return nil }
        guard index < arrayPresentText.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: Key.keyPresentation.rawValue)
            return nil }
        guard let startVC = storyboard?.instantiateViewController(withIdentifier: identifireStartVC) as? StartVC else { return nil }
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


