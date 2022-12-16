//
//  HomeViewModel.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import Foundation

struct HomeViewModel: Equatable {
    var cells: [CharacterCellViewModel]
    var canLoadMore: Bool
    var viewState: ViewState
    
    init(from state: HomeState) {
        cells = state.characters.map(CharacterCellViewModel.init(character:))
        canLoadMore = state.currentPage < state.pageLimit
        viewState = state.viewState
    }
}
