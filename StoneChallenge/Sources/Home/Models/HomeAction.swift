//
//  HomeAction.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation

enum HomeAction {
    case loadMoreItems
    case initialLoad
    case changeFilter(textFilter: String?, statusFilter: RMCharacter.Status?)
}
