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
    var observable: Observable<DetailState> { stateRelay.asObservable() }
    var stateRelay: BehaviorRelay<DetailState>
    var currentState: DetailState { stateRelay.value }
    var actionsReceived: [DetailAction]
    
    init(initialState: DetailState) {
        stateRelay = BehaviorRelay(value: initialState)
        actionsReceived = []
    }
    
    func send(_ action: DetailAction) {
        actionsReceived.append(action)
    }
    
    
}
