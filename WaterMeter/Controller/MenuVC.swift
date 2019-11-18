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
    
    @IBOutlet weak var avatarImg: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
     var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        //NotificationCenter.default.addObserver(self, selector: #selector(userDataChange(_:)), name: Notification.Name("notifUserDate"), object: nil)
        setupView()
    }
    
    func setupView() {
       
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                Firestore.firestore().collection("users").document((user?.uid)!).getDocument(completion: { (user, error) in
                    guard let dict = user?.data(),
                        let name = dict["name"] as? String,
                        let red = dict["red"] as? Double,
                        let green = dict["green"] as? Double,
                        let blue = dict["blue"] as? Double
                    else { return }
                    self.avatarImg.backgroundColor = self.getColorBackFromFirebase(red: red, green: green, blue: blue)
                    self.loginBtn.setTitle(name, for: .normal)
        
                })
//                self.loginBtn.setTitle(user?.displayName, for: .normal)
            } else {
                 self.loginBtn.setTitle("Login", for: .normal)
                self.avatarImg.backgroundColor = self.bgColor
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
    
    func getColorBackFromFirebase(red: Double, green: Double, blue: Double) -> UIColor {
        let red = CGFloat(red)
        let green = CGFloat(green)
        let blue = CGFloat(blue)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
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
