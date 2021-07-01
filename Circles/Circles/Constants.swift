//
//  Constants.swift
//  CirclesC
//
//  Created by Cedric Bahirwe on 7/16/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
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
    
    
    var winners: [CircleUser] {
        get{
            guard let winnersData = UserDefaults.standard.object(forKey: CIRCLESC_WINNERS) as? Data else { return [] }
            
            return try! JSONDecoder().decode([CircleUser].self, from: winnersData)
        }
        set(persons){
            if let encoded = try? JSONEncoder().encode(persons){
                UserDefaults.standard.set(encoded, forKey: CIRCLESC_WINNERS)
            }
        }
    }
    
    public func destroy() {
        UserDefaults.standard.removeObject(forKey: CIRCLESC_BEST_SCORE)
        UserDefaults.standard.removeObject(forKey: CIRCLESC_WINNERS)
    }
}



struct CircleUser: Codable {
    var name: String
    var score: Int
}
