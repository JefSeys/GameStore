//
//  WinkelwagenViewController.swift
//  GameStore
//
//  Created by Jef Seys on 23/12/2020.
//

import Foundation
import UIKit

class WinkelwagenViewController: UIViewController {
    // view attributen
    @IBOutlet var gameTable: UITableView!
    
    // code attributen
    private var games: [Game] = []
    private var winkelwagenService = WinkelwagenService.sharedInstance
    
    override func viewDidLoad() {
      super.viewDidLoad()
        self.games = winkelwagenService.games
        gameTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! WinkelwagenDetailViewController
        detailViewController.selectedGame = games[gameTable.indexPathForSelectedRow!.row]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.games = winkelwagenService.games
        gameTable.reloadData()
    }
    
    func reload(){
        self.games = winkelwagenService.games
        gameTable.reloadData()
    }
}
extension WinkelwagenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WinkelwagenTableView
    let game = games[indexPath.row]
    
        cell.naam.text = game.name
        cell.prijs.text = String(game.price)
    
    return cell
  }
}
