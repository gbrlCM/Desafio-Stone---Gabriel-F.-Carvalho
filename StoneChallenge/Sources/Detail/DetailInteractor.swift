//
//  DetailInteractor.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import RxSwift
import RxRelay
import Foundation

protocol DetailInteractorProtocol: Interactor where State == DetailState, Action == DetailAction {}

final class DetailInteractor: DetailInteractorProtocol, Reducer {
    var store: BehaviorRelay<DetailState>
    var actionSubject: PublishSubject<DetailAction>
    var disposeBag: DisposeBag
    
    
    var observable: Observable<DetailState> { store.asObservable() }
    var currentState: DetailState { store.value }
    
    init(initialState: DetailState) {
        self.store = BehaviorRelay(value: initialState)
        self.actionSubject = PublishSubject()
        self.disposeBag = DisposeBag()
        bind()
    }
    
    func send(_ action: DetailAction) {
        actionSubject.on(.next(action))
    }
    
    func reduce(action: DetailAction, previousState: DetailState) -> Observable<DetailState> {
        switch action {
        case .initialLoad:
            let episodeURL = previousState.character.episode
            let imageURL = previousState.character.image
            
            return Observable
                .combineLatest(CurrentEnv.image.fetch(imageURL), CurrentEnv.api.fetchEpisodes(episodeURL))
                .map { image, episodes in
                    DetailState(character: previousState.character, episodes: episodes, image: image)
                }
        }
    }
}
