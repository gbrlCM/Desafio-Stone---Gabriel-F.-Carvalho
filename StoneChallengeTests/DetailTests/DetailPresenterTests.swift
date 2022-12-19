//
//  DetailPresenterTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

final class DetailPresenterTests: XCTestCase {

    var sut: DetailPresenter!
    var interactorMock: DetailInteractorMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        interactorMock = DetailInteractorMock(initialState: DetailState(character: .mock))
        sut = DetailPresenter(interactor: interactorMock)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertEqual(interactorMock.actionsReceived, [.initialLoad])
    }
    
    func testViewModelMapping() {
        let state = DetailState(character: .mock, episodes: RMCharacter.mock.episode.map {RMEpisode(id: 1, name: $0.absoluteString, episode: $0.absoluteString, airDate: $0.absoluteString) })
        interactorMock.stateRelay.accept(state)
        let expectedResult = DetailViewModel(currentState: state)
        let observer = scheduler.createObserver(DetailViewModel.self)
        
        let expectation = expectation(description: #function)
        
        sut.viewModel
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }

}
