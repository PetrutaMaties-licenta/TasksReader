//
//  ProfileVC.swift
//  WaterMeter
//
//  Created by petruta maties on 13/11/2019.
//  Copyright © 2019 petruta maties. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileVC: UIViewController {
    
    

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var addressTxt: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let authFirebase = Auth.auth()
        do {
            print("logout!")
            try authFirebase.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            debugPrint("Error signing out \(signOutError)")
        }
    }
    
    func setupView() {
        nameTxt.text = Auth.auth().currentUser?.displayName
        emailTxt.text = Auth.auth().currentUser?.email
        Firestore.firestore().collection("users").document((Auth.auth().currentUser?.uid)!).getDocument { (user, error) in
            guard let dict = user?.data() else {return}
            let addr = dict["address"] as! String
            let name = dict["name"] as! String
            self.addressTxt.text = addr
        }
        //addressTxt.text =
    }
    
}
