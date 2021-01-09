//
//  WinkelwagenDetailViewController.swift
//  GameStore
//
//  Created by Jef Seys on 23/12/2020.
//

import Foundation
import UIKit

class WinkelwagenDetailViewController: UIViewController{
    // view attributen
    @IBOutlet weak var name: UILabel!
    
    // code attributen
    private var winkelwagenService = WinkelwagenService.sharedInstance
    private var _selectedGame: Game!
    var selectedGame: Game {
        set { _selectedGame = newValue }
        get { return _selectedGame }
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        name.text = selectedGame.name
    }
    
    // verwijderknop functie
    @IBAction func verwijderGame(_ sender: Any) {
        
        // popup ter bevestiging
        let alert = UIAlertController(title: selectedGame.name + " verwijderen?", message: "Weet u het zeker?", preferredStyle: .alert)
        
        // verwijder
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertAction.Style.default, handler: {(action) in
            self.winkelwagenService.removeGame(game: self.selectedGame)
            alert.dismiss(animated: true, completion: nil)
            
                if let controller = self.navigationController {
                    controller.popViewController(animated: true)
                }
        }))
        
        // verwijder niet
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertAction.Style.cancel, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
