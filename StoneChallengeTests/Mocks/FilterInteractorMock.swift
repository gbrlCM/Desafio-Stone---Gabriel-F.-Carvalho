//
//  FilterInteractorMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

@testable import StoneChallenge
import RxSwift
import RxRelay

final class FilterInteractorMock: FilterInteractorProtocol {
    var observable: Observable<FilterState> { stateRelay.asObservable() }
    var stateRelay: BehaviorRelay<FilterState>
    var currentState: FilterState { stateRelay.value }
    var actionsReceived: [FilterAction]
    
    init(initialState: FilterState) {
        stateRelay = BehaviorRelay(value: initialState)
        actionsReceived = []
    }
    
    func send(_ action: FilterAction) {
        actionsReceived.append(action)
    }
    
    
}

