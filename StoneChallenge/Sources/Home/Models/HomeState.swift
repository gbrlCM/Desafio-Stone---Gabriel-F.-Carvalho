//
//  HomeState.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation

struct HomeState: Equatable {
    var characters: [RMCharacter] = []
    var currentPage: Int = 1
    var pageLimit: Int = 42
    var viewState: ViewState = .loading
    var nameFilter: String?
    var statusFilter: RMCharacter.Status?
}
