//
//  RegisrerOrLoginVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit

class RegisterOrLoginVC: UIViewController {

    
    @IBOutlet weak var registerOrLogin: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var emailTextFild: UITextField!
    @IBOutlet weak var passwordTextFild: UITextField!
    @IBOutlet weak var checkIn: UIButton! {
        didSet {
            checkIn.layer.cornerRadius = 17
        }
    }
    @IBOutlet weak var logIn: UIButton! {
        didSet {
            logIn.layer.cornerRadius = 17
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    
    func startPresentation() {
        
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: "presentationWasViewed5")
        
        if presentationWasViewed == false {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "PageVC") as? PageVC {
                present(pageVC, animated: true)
            }
        }
    }
    
    @IBAction func checkInAction(_ sender: UIButton) {
        print("checkInAction")
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        print("logInAction")
    }
}
