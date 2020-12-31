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
    
    func addGame(game: Game){
        games.append(game)
    }
    
    func removeGame(game: Game){
        //games = games.filter { $0.name != game.name }
        if let index = games.firstIndex(where: { $0.name == game.name }){
            games.remove(at: index)
        }
    }
}
