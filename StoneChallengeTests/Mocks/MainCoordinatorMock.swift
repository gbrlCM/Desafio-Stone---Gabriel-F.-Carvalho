//
//  MainCoordinatorMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

@testable import StoneChallenge
import RxSwift

final class MainCoordinatorMock: MainCoordinatorProtocol {
    var lastCharacterNavigated: RMCharacter?
    var displayFilterWasCalled: Bool = false
    var didCallDismiss: Bool = false
    
    func navigateToCharacter(_ character: RMCharacter) {
        lastCharacterNavigated = character
    }
    
    func displayFilter(resultSubject: PublishSubject<FilterState>) {
        displayFilterWasCalled = true
    }
    
    func dismiss() {
        didCallDismiss = true
    }
}
