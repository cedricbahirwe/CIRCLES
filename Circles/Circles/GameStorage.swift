//
//  GameStorage.swift
//  CirclesC
//
//  Created by Cédric Bahirwe on 01/07/2021.
//  Copyright © 2021 Cedric Bahirwe. All rights reserved.
//

import Foundation


fileprivate let CIRCLESC_WINNERS = "CIRCLESC_WINNERS"
fileprivate let CIRCLESC_BEST_SCORE = "CIRCLESC_BEST_SCORE"

class SessionManager {
    private init(){}
    
    static let shared = SessionManager()
    let defaults = UserDefaults.standard
    
    var bestScore: Int {
        get {
            return defaults.integer(forKey: CIRCLESC_BEST_SCORE)
        }
        set (value) {
            defaults.set(value, forKey: CIRCLESC_BEST_SCORE)
        }
    }
    
    
    var winners: [CPlayer] {
        get{
            guard let winnersData = UserDefaults.standard.object(forKey: CIRCLESC_WINNERS) as? Data else { return [] }
            
            return try! JSONDecoder().decode([CPlayer].self, from: winnersData)
        }
        set(persons){
            if let encoded = try? JSONEncoder().encode(persons){
                UserDefaults.standard.set(encoded, forKey: CIRCLESC_WINNERS)
            }
        }
    }
    
    public func addWinner(_ player: CPlayer) {
        winners.addWinner(player)
    }
    
    public func destroy() {
        UserDefaults.standard.removeObject(forKey: CIRCLESC_BEST_SCORE)
        UserDefaults.standard.removeObject(forKey: CIRCLESC_WINNERS)
    }
}
