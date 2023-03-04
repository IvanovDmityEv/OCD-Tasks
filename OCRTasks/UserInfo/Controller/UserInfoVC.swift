//
//  UserInfoVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 14.12.2022.
//

import UIKit
import Firebase
import FirebaseDatabase


class UserInfoVC: UIViewController {

    var user = User(uid: "", email: "", displayName: "")
    var ref: DatabaseReference!
    let unwindSegueToAutorization = "UnwindSegueToAutorization"
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var signOutButton: UIButton! {
        didSet {
            let height = signOutButton.frame.height
            signOutButton.layer.cornerRadius = height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        
        user.uid = currentUser.uid
        userEmail.text = currentUser.email
        
        ref = Database.database().reference(withPath: "users")
        let userRef = ref.child("\(user.uid)/displayName")
        userRef.getData { error, snapshot in
            guard error == nil else {
              print(error!.localizedDescription)
              return;
            }
            let displayName = snapshot?.value as? String ?? "NoName"
            self.userName.text = displayName
        }
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true)
        performSegue(withIdentifier: unwindSegueToAutorization, sender: nil)
    }
}
