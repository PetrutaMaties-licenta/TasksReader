//
//  CreateAccountVC.swift
//  WaterMeter
//
//  Created by petruta maties on 08/11/2019.
//  Copyright © 2019 petruta maties. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var createAccntBtn: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func bgColorPressed(_ sender: Any) {
        let red = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        UIView.animate(withDuration: 0.3) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_MENU, sender: nil)
    }
    
    @IBAction func createAccntBtnTapped(_ sender: Any) {
        
        guard let email = emailTxt.text,
            let password = passwordTxt.text,
            let name = nameTxt.text,
            let adrress = addressTxt.text else { return }
        
        
        
        
//        Auth.auth().createUser(withEmail: email, password: password)  { (user, error) in  ...  if error == nil {
//            Auth.auth().signIn(withEmail: self.textFieldLoginEmail.text!,
//                               password: self.textFieldLoginPassword.text!)
//            }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
                let controller = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                controller.addAction(action)
                self.present(controller, animated: true, completion: nil)
            }
    
            let changeRequest = user?.user.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    let controller = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    controller.addAction(action)
                    self.present(controller, animated: true, completion: nil)
                    debugPrint(error.localizedDescription)
                }
            })
            guard let userId = user?.user.uid else { return }
            Firestore.firestore().collection("users").document(userId).setData(["name" : name, "dateCreated": FieldValue.serverTimestamp(), "address": adrress], completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    let controller = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    controller.addAction(action)
                    self.present(controller, animated: true, completion: nil)
                } else {
                        self.performSegue(withIdentifier: UNWIND_MENU, sender: nil)
                
                }
            })
        }
        
    }
    
    func setupView() {
        
    }
    
}
