//
//  Reducer.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import RxSwift
import RxRelay

protocol Reducer: AnyObject {
    
    associatedtype State
    associatedtype Action
    
    
    var store: BehaviorRelay<State> { get }
    var actionSubject: PublishSubject<Action> { get }
    var disposeBag: DisposeBag { get }
    
    func bind()
    func reduce(action: Action, previousState: State) -> Observable<State>
}

extension Reducer {
    func bind() {
        actionSubject
            .flatMap {[weak self] action in
                guard let self
                else {
                    preconditionFailure("self is deinitialized")
                }
                return self.reduce(action: action, previousState: self.store.value)
            }
            .bind(to: store)
            .disposed(by: disposeBag)
    }
}
