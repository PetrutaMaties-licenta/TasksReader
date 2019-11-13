//
//  LoginVC.swift
//  WaterMeter
//
//  Created by petruta maties on 08/11/2019.
//  Copyright © 2019 petruta maties. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInUIDelegate {

    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                print("No user logged in!")
            } else {
                print("Welcome user: \(user?.displayName ?? "")")
            }
        }
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        guard let email = emailTxt.text,
            let password = passwordTxt.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
                let controller = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }

    @IBAction func googleSingInTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func loginGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        dismiss(animated: true, completion: nil)
        
    }
    
//
//    @IBAction func logoutTapped(_ sender: Any) {
//        let auth = Auth.auth()
//        do {
//            try auth.signOut()
//        } catch let singOutError as NSError {
//            debugPrint("Error signin out: \(singOutError)")
//        }
//    }
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
               
            }
        }
    }
    
}
