//
//  MenuVC.swift
//  WaterMeter
//
//  Created by petruta maties on 07/11/2019.
//  Copyright © 2019 petruta maties. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MenuVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        //NotificationCenter.default.addObserver(self, selector: #selector(userDataChange(_:)), name: Notification.Name("notifUserDate"), object: nil)
        setupView()
    }
    
    func setupView() {
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.loginBtn.setTitle(user?.displayName, for: .normal)
            } else {
                 self.loginBtn.setTitle("Login", for: .normal)
            }
        }
        
        
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
//    @objc func userDataChange( _ notif: Notification) {
//        if Auth.auth().isSignIn(withEmailLink: Auth.auth().currentUser?.email ?? "") {
//            loginBtn.setTitle(Au, for: .normal)
//
//        }
//
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user == nil {
//                print("No user logged in!")
//            } else {
//                self.loginBtn.setTitle(user?.displayName, for: .normal)
//                print("Welcome user: \(user?.displayName ?? "")")
//            }
//        }
//    }
//    }
}
