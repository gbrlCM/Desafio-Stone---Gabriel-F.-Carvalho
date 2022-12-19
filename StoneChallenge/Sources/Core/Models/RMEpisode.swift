//
//  RMEpisode.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 18/12/22.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let episode: String
    let airDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case episode
        case airDate = "air_date"
    }
}
