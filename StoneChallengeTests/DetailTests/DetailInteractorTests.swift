//
//  DetailInteractorTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import XCTest
import RxSwift
import RxTest

@testable import StoneChallenge

final class DetailInteractorTests: XCTestCase {

    var sut: DetailInteractor!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        sut = DetailInteractor(initialState: DetailViewState(character: .mock))
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        CurrentEnv = .mock
    }
    
    override func tearDown() {
        sut = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testSendInitialLoadAction() {
        let characterMock = RMCharacter.mock
        let expectedState = DetailViewState(
            character: characterMock,
            episodes: RMEpisode.mock(for: characterMock.episode),
            image: ImageReferences.mock
        )
        let observer = scheduler.createObserver(DetailViewState.self)
        
        let expectation = expectation(description: #function)
        
        sut.send(.initialLoad)
        
        sut
            .observable
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedState])
    }
    
    func testCurrentState() {
        sut.store.accept(DetailViewState(character: .mock))
        XCTAssertEqual(sut.currentState, DetailViewState(character: .mock))
    }

}
