//
//  RMCharacter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import Foundation

struct RMCharacter: Codable {
    let id: String
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let localtion: Location
    let image: URL
    let episode: [URL]
    
    struct Origin: Codable {
        let name: String
    }
    
    struct Location: Codable {
        let name: String
    }
    
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "Unknown"
    }
}
