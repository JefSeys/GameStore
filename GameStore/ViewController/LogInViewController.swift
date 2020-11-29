//
//  LogInViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var wachtwoord: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    private var _isIngelogd: Bool = false
    var isIngelogd: Bool {
        set { _isIngelogd = newValue }
        get { return _isIngelogd }
    }
    
    @IBAction func login(_ sender: Any) {
        //errorMessage.isHidden = true
        loadIcon.startAnimating()
        APIManager.loginUser(email: email.text!, password: wachtwoord.text!){ [self] ingelogd in
            if(ingelogd == true){
                loadIcon.stopAnimating()
                navigateMain()
            }else{
                loadIcon.stopAnimating()
                errorMessage.text = "Er is iets fout gelopen tijdens het inloggen"
                errorMessage.isHidden = false
            }
          }
    }
    
    private func navigateMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
        guard let mainNavigationVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationViewController else{
            return
        }
        
        
        present(mainNavigationVC, animated: false, completion: nil)
    }
}
