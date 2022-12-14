//
//  RegistrationVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 14.12.2022.
//

import UIKit
import Firebase

class RegistrationVC: UIViewController {

    @IBOutlet weak var newUserPhoto: UIImageView! {
        didSet {
            let height = newUserPhoto.frame.height
            newUserPhoto.layer.cornerRadius = height/2
        }
    }
    @IBOutlet weak var newUserName: UITextField!
    @IBOutlet weak var newUserEmail: UITextField!
    @IBOutlet weak var newUserPassword: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var register: UIButton! {
        didSet {
            register.layer.cornerRadius = 17
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // наблюдатели для клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        message.alpha = 0
        
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keybordSize = (userInfo[RegistrationVC.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keybordSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    func warning(widthText text: String) {
        message.text = text
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.message.alpha = 1
        }) { [weak self] complete in
            self?.message.alpha = 0
        }
    }
    
    @IBAction func registerNewUser(_ sender: UIButton) {
        guard let email = newUserEmail.text,
                let password = newUserPassword.text,
                email != "",
                password != "" else {
            warning(widthText: Messages.infoIsIncorrect.rawValue)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil, user != nil  else  { return }
            
            //надо подумать + добавить сообщение и задержку
            self.performSegue(withIdentifier: "UserRegisteredSegue", sender: nil)
            
//            if error == nil {
//                if user != nil {
//
//                }
//            }
        }
    }
}
