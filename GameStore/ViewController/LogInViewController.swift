//
//  LogInViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
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
        
            // tap op scherm sluit keyboard
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
           view.addGestureRecognizer(tap)
    }
    
    // keyboard sluit als scherm niet meer zichtbaar is
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            
        guard let mainNavigationVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController else{
            return
        }
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changRootViewController(mainNavigationVC)
    }
}
