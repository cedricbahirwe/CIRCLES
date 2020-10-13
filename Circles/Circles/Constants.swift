//
//  Constants.swift
//  CirclesC
//
//  Created by Cedric Bahirwe on 7/16/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import Foundation

let CIRCLESC_WINNERS = "CIRCLESC_WINNERS"
let CIRCLESC_PLAYER_ISLOGGEDIN = "CIRCLES_PLAYER_ISLOGGEDIN"
let CIRCLESC_USER = "CIRCLESC_USER"

let CIRCLESC_BEST_SCORE = "CIRCLESC_BEST_SCORE"

class SessionManager {
    private init(){}
    
    static let instance = SessionManager()
    let defaults = UserDefaults.standard
    
    var winners : [String: Int] {
        get {
            return defaults.dictionary(forKey: CIRCLESC_WINNERS) as? [String : Int] ?? [:]
        }set (value){
            defaults.set(value,forKey: CIRCLESC_WINNERS)
        }
    }
    
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: CIRCLESC_PLAYER_ISLOGGEDIN)
        }
        set (value){
            defaults.set(value, forKey: CIRCLESC_PLAYER_ISLOGGEDIN)
        }
    }
    var bestScore: Int {
        get {
            return defaults.integer(forKey: CIRCLESC_BEST_SCORE)
        }
        set (value) {
            defaults.set(value, forKey: CIRCLESC_BEST_SCORE)
        }
    }
    
    
    var HelloKigaliUser : CirclesUser?{
        get{
            guard let personInfo = UserDefaults.standard.object(forKey: CIRCLESC_USER) as? Data else {return nil}
            
            return try! JSONDecoder().decode(CirclesUser.self, from: personInfo)
        }
        set(person){
            if let encoded = try? JSONEncoder().encode(person){
                UserDefaults.standard.set(encoded, forKey: CIRCLESC_USER)
            }
        }
    }
    
    func destroy() {
        UserDefaults.standard.removeObject(forKey: CIRCLESC_BEST_SCORE)
        
    }
}



struct CirclesUser: Codable {
    var name: String
    var score: Int
}
