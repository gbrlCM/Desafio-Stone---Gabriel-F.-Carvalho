//
//  EpisodeCellViewmodel.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import Foundation

struct EpisodeCellViewModel {
    let title: String
    let subtitle: String
    
    init(episode: RMEpisode) {
        self.title = "\(episode.episode) - \(episode.name)"
        self.subtitle = episode.airDate
    }
}
