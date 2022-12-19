//
//  DetailInteractorMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

@testable import StoneChallenge
import RxSwift
import RxRelay

final class DetailInteractorMock: DetailInteractorProtocol {
    var observable: Observable<DetailViewState> { stateRelay.asObservable() }
    var stateRelay: BehaviorRelay<DetailViewState>
    var currentState: DetailViewState { stateRelay.value }
    var actionsReceived: [DetailAction]
    
    init(initialState: DetailViewState) {
        stateRelay = BehaviorRelay(value: initialState)
        actionsReceived = []
    }
    
    func send(_ action: DetailAction) {
        actionsReceived.append(action)
    }
    
    
}
