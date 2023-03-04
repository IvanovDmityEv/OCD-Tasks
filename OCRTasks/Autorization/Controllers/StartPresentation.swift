//
//  StartPresentation.swift
//  OCRTasks
//
//  Created by Dmitriy on 06.02.2023.
//

import Foundation

extension AutorizationVC {
    func startPresentation() {
        
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: Key.keyPresentation.rawValue)
        
        if presentationWasViewed == false {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "PageVC") as? PageVC {
                self.present(pageVC, animated: true)
            }
        }
    }
}
