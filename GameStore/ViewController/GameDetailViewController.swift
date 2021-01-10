//
//  GameDetailViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class GameDetailViewController: UIViewController{
    // view attributen
    @IBOutlet weak var naam: UILabel!
    @IBOutlet weak var prijs: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    // code attributen
    private var _selectedGame: Game!
    var selectedGame: Game {
        set { _selectedGame = newValue }
        get { return _selectedGame }
    }
    private var winkelwagenService = WinkelwagenService.sharedInstance

    
    // animatie
    override func viewWillAppear(_ animated: Bool) {
        naam.center.x -= view.bounds.width
        prijs.center.x -= view.bounds.width
        imgView.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        naam.text = selectedGame.name
        prijs.text = "Prijs: " + String(selectedGame.price) + " euro"
        
        let data = Data(base64Encoded: selectedGame.base64Img.replacingOccurrences(of: "data:image/jpeg;base64,", with: ""), options: .ignoreUnknownCharacters)
        imgView.image = UIImage(data: data!)
    }
    
    // toevoegen aan winkelwagen functie
    @IBAction func voegToeAanWinkelwagen(_ sender: Any) {
        let alert = UIAlertController(title: selectedGame.name + " toevoegen?", message: "Weet u het zeker?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ja", style: UIAlertAction.Style.default, handler: {(action) in
            self.winkelwagenService.addGame(game: self.selectedGame)
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Nee", style: UIAlertAction.Style.cancel, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
