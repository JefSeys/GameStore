//
//  GameDetailViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class GameDetailViewController: UIViewController{
    var selectedGame: Game!
    var winkelwagenService = WinkelwagenService.sharedInstance
    
    @IBOutlet weak var naam: UILabel!
    @IBOutlet weak var prijs: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        naam.text = selectedGame.name
        prijs.text = String(selectedGame.price)
        
        let data = Data(base64Encoded: selectedGame.base64Img.replacingOccurrences(of: "data:image/jpeg;base64,", with: ""), options: .ignoreUnknownCharacters)
        imgView.image = UIImage(data: data!)
    }
    
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
