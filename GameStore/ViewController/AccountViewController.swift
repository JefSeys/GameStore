//
//  AccountViewController.swift
//  GameStore
//
//  Created by Jef Seys on 29/11/2020.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    // view attributen
    @IBOutlet weak var email: UILabel!
    
    // code attributen
    private let apiManager = APIManager.shared
    
    override func viewDidLoad() {
      super.viewDidLoad()
        email.text = apiManager.gebruikerEmail
    }
    
    
    @IBAction func loguit(_ sender: Any) {
        apiManager.loguit()
        navigateLogin()
    }
    
    // verandert rootViewController naar login met animatie (via SceneDelegate.swift)
    func navigateLogin(){
        
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
            guard let mainNavigationVC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController else{
                return
            }
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changRootViewController(mainNavigationVC)
    }
}
