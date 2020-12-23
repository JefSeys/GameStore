//
//  WinkelwagenDetailViewController.swift
//  GameStore
//
//  Created by Jef Seys on 23/12/2020.
//

import Foundation
import UIKit

class WinkelwagenDetailViewController: UIViewController{
    var winkelwagenService = WinkelwagenService.sharedInstance
    @IBOutlet weak var name: UILabel!
    var selectedGame: Game!
    override func viewDidLoad() {
      super.viewDidLoad()
        name.text = selectedGame.name
    }
    
    @IBAction func verwijderGame(_ sender: Any) {
        let alert = UIAlertController(title: selectedGame.name + " verwijderen?", message: "Weet u het zeker?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertAction.Style.default, handler: {(action) in
            self.winkelwagenService.removeGame(game: self.selectedGame)
            alert.dismiss(animated: true, completion: nil)
            
                if let controller = self.navigationController {
                    controller.popViewController(animated: true)
                }
        }))
        
        
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertAction.Style.cancel, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
