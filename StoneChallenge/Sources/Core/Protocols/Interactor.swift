//
//  Interactor.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import RxSwift
import RxRelay

protocol Interactor: AnyObject {
    associatedtype State
    associatedtype Action
    
    var observable: Observable<State> { get }
    var currentState: State { get }
    
    init(initialState: State)
    
    func send(_ action: Action)
}
