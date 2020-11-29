//
//  RegistreerViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class RegistreerViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var voornaam: UITextField!
    @IBOutlet weak var achternaam: UITextField!
    @IBOutlet weak var wachtwoord: UITextField!
    @IBOutlet weak var herhaalwachtwoord: UITextField!
    
    @IBOutlet weak var laadicon: UIActivityIndicatorView!
    @IBOutlet weak var errormessage: UILabel!
    
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
    
    @IBAction func registreer(_ sender: Any) {
        errormessage.isHidden = true
        laadicon.startAnimating()
        
        if voornaam.text == "" {
            laadicon.stopAnimating()
            errormessage.text = "Voornaam is leeg"
            errormessage.isHidden = false
        }else if achternaam.text == "" {
            laadicon.stopAnimating()
            errormessage.text = "Achternaam is leeg"
            errormessage.isHidden = false
        }else if email.text == "" {
            laadicon.stopAnimating()
            errormessage.text = "Email is leeg"
            errormessage.isHidden = false
        }else if wachtwoord.text == "" {
            laadicon.stopAnimating()
            errormessage.text = "Wachtwoord is leeg"
            errormessage.isHidden = false
        }else if herhaalwachtwoord.text == "" {
            laadicon.stopAnimating()
            errormessage.text = "Herhaal het wachtwoord"
            errormessage.isHidden = false
        }else if wachtwoord.text != herhaalwachtwoord.text {
            laadicon.stopAnimating()
            errormessage.text = "Wachtwoorden komen niet overeen"
            errormessage.isHidden = false
        }else{
            APIManager.registreer(email: email.text!, password: wachtwoord.text!, voornaam: voornaam.text!, achternaam: achternaam.text!, herhaalwachtwoord: herhaalwachtwoord.text!){ [self] geregistreerd in
                if(geregistreerd == true){
                    laadicon.stopAnimating()
                    //navigateLogin()
                    errormessage.text = "Registratie voltooid!"
                    errormessage.isHidden = false
                }else{
                    laadicon.stopAnimating()
                    errormessage.text = "Er is iets fout gelopen tijdens het registreren"
                    errormessage.isHidden = false
                }
              }
        }
    }
    
    func navigateLogin(){
        if let controller = self.navigationController {
            controller.popViewController(animated: true)
        }
    }
}
