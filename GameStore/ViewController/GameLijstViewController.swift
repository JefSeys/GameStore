//
//  GameLijstViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class GameLijstViewController: UIViewController {
    
    var games: [Game] = []
    @IBOutlet var gameTable: UITableView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        APIManager.getGames{ [self] gamesLijst in
          self.games = gamesLijst
            gameTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! GameDetailViewController
            // Pass on the data to the Detail ViewController by setting it's indexPathRow value
        detailViewController.selectedGame = games[gameTable.indexPathForSelectedRow!.row]
    }
    
}

extension GameLijstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameTableView
    let game = games[indexPath.row]
    
        cell.naam.text = game.name
        cell.prijs.text = String(game.price)
    
    return cell
  }
}
