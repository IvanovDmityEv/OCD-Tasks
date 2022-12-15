//
//  UserInfoVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 14.12.2022.
//

import UIKit
import Firebase

class UserInfoVC: UIViewController {

    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var signOutButton: UIButton! {
        didSet {
            let height = signOutButton.frame.height
            signOutButton.layer.cornerRadius = height/2
        }
    }
    
    let unwindSegue = "UnwindSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutAction(_ sender: UIButton) {
//                 подумать как это переделать
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true)
        performSegue(withIdentifier: unwindSegue, sender: nil)
    }
}
