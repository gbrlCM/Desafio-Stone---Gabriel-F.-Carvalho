//
//  DetailViewModel.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import Foundation

struct DetailViewModel: Equatable {
    let title: String
    let header: HeaderViewModel
    let episodeCells: [EpisodeCellViewModel]
    
    init(currentState: DetailState) {
        self.title = currentState.character.name
        self.header = HeaderViewModel(
            image: currentState.image,
            status: currentState.character.status,
            gender: currentState.character.gender,
            species: currentState.character.species
        )
        self.episodeCells = currentState.episodes.map(EpisodeCellViewModel.init(episode:))
    }
}
