//
//  RegisrerOrLoginVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
//import FirebaseAuth

class AutorizationVC: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            let height = signUpButton.frame.height
            signUpButton.layer.cornerRadius = height/2
        }
    }
    @IBOutlet weak var logInButton: UIButton! {
        didSet {
            let height = logInButton.frame.height
            logInButton.layer.cornerRadius = height/2
        }
    }
    
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView! {
        didSet {
            activitiIndicator.hidesWhenStopped = true
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startPresentation()
        
        // проверка на наличие входа пользователя
        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            
             if user != nil {

                 self?.performSegue(withIdentifier: SegueAutorization.logIn.rawValue, sender: nil)
             }
         }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Auth.auth().removeStateDidChangeListener(handle!)
        
        activitiIndicator.hidesWhenStopped = true
        activitiIndicator.stopAnimating()
    }
    

    
    @IBAction func signUpAction(_ sender: UIButton) {
        autorizationAlertController(button: signUpButton)
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        autorizationAlertController(button: logInButton)
    }
    
    
    @IBAction func unwindSegueToLoginVC(segue: UIStoryboardSegue) {
        guard segue.identifier == SegueAutorization.unwindSegueToAutorization.rawValue else { return }
    }
}

