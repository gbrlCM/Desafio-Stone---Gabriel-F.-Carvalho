//
//  FilterAction.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import Foundation

enum FilterAction: Equatable {
    case updateText(_ content: String?)
    case changeStatus(_ newValue: RMCharacter.Status?)
}
