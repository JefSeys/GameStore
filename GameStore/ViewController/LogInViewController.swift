//
//  LogInViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // view attributen
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var wachtwoord: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    
    // code attributen
    private let apiManager = APIManager.shared
    private var _isIngelogd: Bool = false
    var isIngelogd: Bool {
        set { _isIngelogd = newValue }
        get { return _isIngelogd }
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        email.delegate = self
        wachtwoord.delegate = self
            // tap op scherm sluit toetsenbord
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
    }
    
    // sluit toetsenbord
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // sluit toetsenbord op returnkey
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // loginknop functie
    @IBAction func login(_ sender: Any) {
        errorMessage.isHidden = true
        loadIcon.startAnimating()
        apiManager.loginUser(email: email.text!, password: wachtwoord.text!){ [self] ingelogd in
            if(ingelogd == true){
                loadIcon.stopAnimating()
                navigateMain()
            }else{
                loadIcon.stopAnimating()
                errorMessage.text = "Email of wachtwoord verkeerd"
                errorMessage.isHidden = false
            }
          }
    }
    
    // verandert rootviewcontroller naar tabbar met animatie (via SeneDelegate.swift)
    private func navigateMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
        guard let tabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{
            return
        }
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changRootViewController(tabBar)
    }
}
