//
//  DetailInteractor.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import RxSwift
import RxRelay
import Foundation

protocol DetailInteractorProtocol: Interactor where State == DetailViewState, Action == DetailAction {}

final class DetailInteractor: DetailInteractorProtocol, Reducer {
    var store: BehaviorRelay<DetailViewState>
    var actionSubject: PublishSubject<DetailAction>
    var disposeBag: DisposeBag
    
    
    var observable: Observable<DetailViewState> { store.asObservable() }
    var currentState: DetailViewState { store.value }
    
    init(initialState: DetailViewState) {
        self.store = BehaviorRelay(value: initialState)
        self.actionSubject = PublishSubject()
        self.disposeBag = DisposeBag()
        bind()
    }
    
    func send(_ action: DetailAction) {
        actionSubject.on(.next(action))
    }
    
    func reduce(action: DetailAction, previousState: DetailViewState) -> Observable<DetailViewState> {
        switch action {
        case .initialLoad:
            let episodeURL = previousState.character.episode
            let imageURL = previousState.character.image
            
            return Observable
                .combineLatest(CurrentEnv.image.fetch(imageURL), CurrentEnv.api.fetchEpisodes(episodeURL))
                .map { image, episodes in
                    DetailViewState(character: previousState.character, episodes: episodes, image: image)
                }
        }
    }
}
