//
//  GameLijstViewController.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import Foundation
import UIKit

class GameLijstViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    // view attributen
    @IBOutlet var gameTable: UITableView!
    
    // code attributen
    private let apiManager = APIManager.shared
    var games: [Game] = []
    var filteredGames: [Game] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        // zoekbalk instellen
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Game"
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        apiManager.getGames{ [self] gamesLijst in
          self.games = gamesLijst
            gameTable.reloadData()
        }
    }
    
    // gekozen game details instellen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! GameDetailViewController
        let indexPath = gameTable.indexPathForSelectedRow
        let game: Game
        if isFiltering {
            game = filteredGames[indexPath?.row ?? 0]
        } else {
            game = games[indexPath?.row ?? 0]
        }
        detailViewController.selectedGame = game
    }
    
    // boolean die aangeeft of zoekbalk leeg is of niet
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    // boolean die aangeeft of zoekbalk moet filteren of niet => niet toont de volledige gamelijst anders filter
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    // filter op naam
    func filterContentForSearchText(_ searchText: String) {
      filteredGames = games.filter { (game: Game) -> Bool in
        return game.name.lowercased().contains(searchText.lowercased())
      }
        gameTable.reloadData()
    }
}

extension GameLijstViewController: UITableViewDataSource {
    // aantal rijen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredGames.count
        }
    return games.count
  }
 
    // cell info instellen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameTableView
        let game: Game
        if isFiltering {
          game = filteredGames[indexPath.row]
        } else {
          game = games[indexPath.row]
        }
    
        cell.naam.text = game.name
        cell.prijs.text = "Prijs: " + String(game.price) + " euro"
        let data = Data(base64Encoded: game.base64Img.replacingOccurrences(of: "data:image/jpeg;base64,", with: ""), options: .ignoreUnknownCharacters)
        cell.img.image = UIImage(data: data!)
    
    return cell
  }
}

extension GameLijstViewController: UISearchResultsUpdating {
    // filter games
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
