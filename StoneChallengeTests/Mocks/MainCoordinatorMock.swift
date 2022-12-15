//
//  MainCoordinatorMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

@testable import StoneChallenge

final class MainCoordinatorMock: MainCoordinatorProtocol {
    var lastCharacterNavigated: RMCharacter?
    var displayFilterWasCalled: Bool = false
    
    func navigateToCharacter(_ character: RMCharacter) {
        lastCharacterNavigated = character
    }
    
    func displayFilter() {
        displayFilterWasCalled = true
    }
}
