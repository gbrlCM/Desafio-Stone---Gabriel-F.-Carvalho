//
//  CharactersResponse.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation

struct CharactersResponse: Codable, Equatable {
    var info: Info
    var results: [RMCharacter]
    
    struct Info: Codable, Equatable {
        let count: Int
        let pages: Int
    }
}
