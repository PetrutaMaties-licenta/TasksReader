//
//  MainVC.swift
//  WaterMeter
//
//  Created by petruta maties on 07/11/2019.
//  Copyright © 2019 petruta maties. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // Outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }


}
