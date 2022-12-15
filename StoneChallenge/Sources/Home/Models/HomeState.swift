//
//  HomeState.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation

struct HomeState {
    var characters: [CharacterCellViewModel] = []
    var currentPage: Int = 1
    var viewState: ViewState = .loading
    var nameFilter: String?
    var statusFilter: RMCharacter.Status?
}
