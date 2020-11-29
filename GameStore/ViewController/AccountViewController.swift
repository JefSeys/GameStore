//
//  AccountViewController.swift
//  GameStore
//
//  Created by Jef Seys on 29/11/2020.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var email: UILabel!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        email.text = APIManager.gebruikerEmail
    }
    
    
    @IBAction func loguit(_ sender: Any) {
        APIManager.loguit()
        navigateLogin()
    }
    
    func navigateLogin(){
        
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
            guard let mainNavigationVC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController else{
                return
            }
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changRootViewController(mainNavigationVC)
    }
}
