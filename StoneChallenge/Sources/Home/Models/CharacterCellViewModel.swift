//
//  CharacterCellViewModel.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation

struct CharacterCellViewModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageUrl: URL
    
    init(character: RMCharacter) {
        self.id = character.id
        self.name = character.name
        self.imageUrl = character.image
    }
}
