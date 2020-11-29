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
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

           //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
           //tap.cancelsTouchesInView = false

           view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        errorMessage.isHidden = true
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
            
        guard let mainNavigationVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{
            return
        }
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changRootViewController(mainNavigationVC)
    }
}
