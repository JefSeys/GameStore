//
//  ViewController.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//

import UIKit

class ViewController: UIViewController {

    var hey = "hey"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clicked(_ sender: Any) {
        hey = "hallo"
        APIManager.loginUser(email: "jef.seys@gmail.com",
                             password: "P@ssword1111")
    }


}

