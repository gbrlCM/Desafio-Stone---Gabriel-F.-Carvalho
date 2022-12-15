//
//  HomePresenterTest.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import XCTest
import RxSwift
import RxTest
@testable import StoneChallenge

final class HomePresenterTest: XCTestCase {

    var sut: HomePresenter!
    var interactorMock: HomeInteractorMock!
    var coordinatorMock: MainCoordinatorMock!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        interactorMock = HomeInteractorMock(initialState: HomeState())
        coordinatorMock = MainCoordinatorMock()
        sut = HomePresenter(interactor: interactorMock)
        sut.mainCoordinator = coordinatorMock
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        coordinatorMock = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func testInitialLoad() {
        sut.initialLoad()
        
        XCTAssertEqual(interactorMock.actionsSended, [.initialLoad])
    }
    
    func testLoadMoreItems() {
        sut.loadMoreItems()
        
        XCTAssertEqual(interactorMock.actionsSended, [.loadMoreItems])
    }
    
    func testDisplayFilter() {
        sut.displayFilter()
        
        XCTAssertTrue(coordinatorMock.displayFilterWasCalled)
    }
    
    func testItemSelected() {
        let mockState = HomeState(
            characters: [
                RMCharacter(
                    id: 1,
                    name: "mock",
                    status: .alive,
                    species: "male",
                    type: "mock",
                    gender: "mock",
                    origin: .init(name: "mock"),
                    location: .init(name: "mock"),
                    image: URL(string: "https://mock.com/mock")!,
                    episode: [])
            ],
            currentPage: 2,
            pageLimit: 4,
            viewState: .loaded
        )
        
        interactorMock.stateRelay.accept(mockState)
        
        sut.itemSelected(at: 0)
        
        XCTAssertEqual(coordinatorMock.lastCharacterNavigated!, mockState.characters.first!)
    }
    
    func testItemSelectedOnIncorrectIndex() {
        let mockState = HomeState(
            characters: [
                RMCharacter(
                    id: 1,
                    name: "mock",
                    status: .alive,
                    species: "male",
                    type: "mock",
                    gender: "mock",
                    origin: .init(name: "mock"),
                    location: .init(name: "mock"),
                    image: URL(string: "https://mock.com/mock")!,
                    episode: [])
            ],
            currentPage: 2,
            pageLimit: 4,
            viewState: .loaded
        )
        
        interactorMock.stateRelay.accept(mockState)
        
        sut.itemSelected(at: 1)
        
        XCTAssertNil(coordinatorMock.lastCharacterNavigated)
    }
    
    func testViewModelMapping() {
        let mockState = HomeState(
            characters: [
                RMCharacter(
                    id: 1,
                    name: "mock",
                    status: .alive,
                    species: "male",
                    type: "mock",
                    gender: "mock",
                    origin: .init(name: "mock"),
                    location: .init(name: "mock"),
                    image: URL(string: "https://mock.com/mock")!,
                    episode: [])
            ],
            currentPage: 2,
            pageLimit: 4,
            viewState: .loaded
        )
        
        let expectedViewModel = HomeViewModel(from: mockState)
        
        interactorMock.stateRelay.accept(mockState)
        
        let observer = scheduler.createObserver(HomeViewModel.self)
        let expectation = expectation(description: #function)
        
        sut.viewModel
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedViewModel])
    }
}
