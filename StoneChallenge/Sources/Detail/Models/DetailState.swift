//
//  DetailViewState.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import UIKit

struct DetailState: Equatable {
    let character: RMCharacter
    let episodes: [RMEpisode]
    let image: UIImage?
    
    init(character: RMCharacter, episodes: [RMEpisode] = [], image: UIImage? = nil) {
        self.character = character
        self.episodes = episodes
        self.image = image
    }
}
