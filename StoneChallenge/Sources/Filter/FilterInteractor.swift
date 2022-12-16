//
//  FilterInteractor.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import Foundation
import RxSwift
import RxRelay

protocol FilterInteractorProtocol: Interactor where State == FilterState, Action == FilterAction {}

final class FilterInteractor: FilterInteractorProtocol, Reducer {
    
    var store: BehaviorRelay<FilterState>
    var actionSubject: PublishSubject<FilterAction>
    var disposeBag: DisposeBag
    
    var observable: Observable<FilterState> {
        store.asObservable()
    }
    var currentState: FilterState {
        store.value
    }
    
    init(initialState: FilterState) {
        store = BehaviorRelay(value: initialState)
        actionSubject = PublishSubject()
        disposeBag = DisposeBag()
        bind()
    }
    
    func reduce(action: FilterAction, previousState: FilterState) -> Observable<FilterState> {
        switch action {
        case .updateText(let newValue):
            var newState = previousState
            newState.text = newValue
            
            return .just(newState)
            
        case .changeStatus(let newValue):
            var newState = previousState
            newState.status = previousState.status == newValue ? nil : newValue
            
            return .just(newState)
        }
    }
    
    func send(_ action: FilterAction) {
        actionSubject.on(.next(action))
    }
    
}
