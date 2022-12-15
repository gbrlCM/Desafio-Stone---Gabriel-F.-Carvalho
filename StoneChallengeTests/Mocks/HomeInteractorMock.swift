//
//  HomeInteractorMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

@testable import StoneChallenge
import RxSwift
import RxRelay

final class HomeInteractorMock: HomeInteractorProtocol {
    
    var stateRelay: BehaviorRelay<HomeState>
    var observable: Observable<HomeState> {
        stateRelay.asObservable()
    }
    
    var currentState: HomeState {
        stateRelay.value
    }
    
    var actionsSended: [HomeAction]
    
    init(initialState: HomeState) {
        self.stateRelay = BehaviorRelay(value: initialState)
        self.actionsSended = []
    }
    
    func send(_ action: HomeAction) {
        actionsSended.append(action)
    }
    
    
}
