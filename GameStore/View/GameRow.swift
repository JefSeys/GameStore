//
//  GameRow.swift
//  GameStore
//
//  Created by Jef Seys on 26/11/2020.
//

import SwiftUI

struct GameRow: View {
    var game: Game
    
    var body: some View{
        Text(game.fullName)
        Spacer()
    }
}
