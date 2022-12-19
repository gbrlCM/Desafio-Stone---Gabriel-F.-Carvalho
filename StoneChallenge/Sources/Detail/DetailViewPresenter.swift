//
//  DetailViewPresenter.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import UIKit
import RxSwift

protocol DetailPresenterProcotol {
    var viewModel: Observable<DetailViewModel> { get }
    
    func viewDidLoad()
}

final class DetailPresenter: DetailPresenterProcotol {
    var viewModel: Observable<DetailViewModel> {
        interactor
            .observable
            .map(DetailViewModel.init(currentState:))
    }
    
    private let interactor: any DetailInteractorProtocol
    
    init(interactor: some DetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor.send(.initialLoad)
    }
}

import RxRelay

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

struct DetailViewState {
    let character: RMCharacter
    let episodes: [RMEpisode]
    let image: UIImage?
    
    init(character: RMCharacter, episodes: [RMEpisode] = [], image: UIImage? = nil) {
        self.character = character
        self.episodes = episodes
        self.image = image
    }
}

enum DetailAction {
    case initialLoad
}

struct DetailViewModel {
    let title: String
    let header: HeaderViewModel
    let episodeCells: [EpisodeCellViewModel]
    
    init(currentState: DetailViewState) {
        self.title = currentState.character.name
        self.header = HeaderViewModel(
            image: currentState.image,
            status: currentState.character.status,
            gender: currentState.character.gender,
            species: currentState.character.species
        )
        self.episodeCells = currentState.episodes.map(EpisodeCellViewModel.init(episode:))
    }
}

struct HeaderViewModel {
    let image: UIImage?
    let status: RMCharacter.Status
    let gender: String
    let species: String
}
