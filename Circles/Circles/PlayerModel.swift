//
//  PlayerModel.swift
//  CirclesC
//
//  Created by Cédric Bahirwe on 01/07/2021.
//  Copyright © 2021 Cedric Bahirwe. All rights reserved.
//

import Foundation

struct CPlayer: Codable, Equatable {
    var name: String
    var score: Int
    
    mutating func updateScore(_ score: Int) {
        self.score = score
    }
}

extension Array where Element == CPlayer {
    mutating func addWinner(_ player: Element) {
        if let index = firstIndex(of: player) {
            self[index] = player
        } else {
            append(player)
        }
    }
}
