//
//  RegisrerOrLoginVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 03.12.2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var emailTextFild: UITextField!
    @IBOutlet weak var passwordTextFild: UITextField!
    @IBOutlet weak var register: UIButton! {
        didSet {
            register.layer.cornerRadius = 17
        }
    }
    @IBOutlet weak var login: UIButton! {
        didSet {
            login.layer.cornerRadius = 17
        }
    }
    
    private let identifirePageVC = "PageVC"
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.alpha = 0
        
        // наблюдатели для клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(kbDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // проверка на наличие входа пользователя

        handle = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
             if user != nil {
                 self?.performSegue(withIdentifier: SegueLoginVC.tasksList.rawValue, sender: nil)
             }
         }
        
        emailTextFild.text = ""
        passwordTextFild.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(handle!)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    

    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keybordSize = (userInfo[LoginVC.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.size.height + keybordSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
    }

    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.size.height)
    }
    
    func startPresentation() {
        
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: Key.keyPresentation.rawValue)
        
        if presentationWasViewed == false {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: identifirePageVC) as? PageVC {
                present(pageVC, animated: true)
            }
        }
    }
    
    // ошибки при регистрации
    func warning(widthText text: String) {
        message.text = text
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.message.alpha = 1
        }) { [weak self] complete in
            self?.message.alpha = 0
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        guard let email = emailTextFild.text,
                let password = passwordTextFild.text,
                email != "",
                password != "" else {
            warning(widthText: Messages.infoIsIncorrect.rawValue)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.warning(widthText: Messages.errorOccurred.rawValue)
                return
            }
            if user != nil {
//                self?.performSegue(withIdentifier: SegueLoginVC.tasksList.rawValue, sender: nil)
                return
            }
            self?.warning(widthText: Messages.noSuchUser.rawValue)
        }
    }
    
    @IBAction func registrationAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: SegueLoginVC.registration.rawValue, sender: nil)
    }
    
    
    @IBAction func unwindSegueToMainScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == SegueLoginVC.unwindSegue.rawValue else { return }
    }
}