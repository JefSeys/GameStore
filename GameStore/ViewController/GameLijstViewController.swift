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
    var filteredGames: [Game] = []
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet var gameTable: UITableView!
    
    
    override func viewDidLoad() {
      super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        APIManager.getGames{ [self] gamesLijst in
          self.games = gamesLijst
            gameTable.reloadData()
        }
    }
    
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
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredGames = games.filter { (game: Game) -> Bool in
        return game.name.lowercased().contains(searchText.lowercased())
      }
        gameTable.reloadData()
    }
}

extension GameLijstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredGames.count
        }
    return games.count
  }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GameTableView
        let game: Game
        if isFiltering {
          game = filteredGames[indexPath.row]
        } else {
          game = games[indexPath.row]
        }
    
        cell.naam.text = game.name
        cell.prijs.text = String(game.price)
    
    return cell
  }
}

extension GameLijstViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
