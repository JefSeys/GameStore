//
//  WinkelwagenService.swift
//  GameStore
//
//  Created by Jef Seys on 23/12/2020.
//

import Foundation

class WinkelwagenService {
    static let sharedInstance = WinkelwagenService()
    var games: [Game] = []
    
    // toevoegen 1 game
    func addGame(game: Game){
        games.append(game)
    }
    
    // verwijder 1 game
    func removeGame(game: Game){
        if let index = games.firstIndex(where: { $0.name == game.name }){
            games.remove(at: index)
        }
    }
}
