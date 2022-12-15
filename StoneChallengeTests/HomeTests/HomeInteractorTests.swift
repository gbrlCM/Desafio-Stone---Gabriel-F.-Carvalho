//
//  HomeInteractorTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import XCTest
import RxSwift
import RxTest
@testable import StoneChallenge

final class HomeInteractorTests: XCTestCase {

    var sut: HomeInteractor!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        CurrentEnv = .mock
        sut = HomeInteractor(initialState: HomeState())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testCurrentState() {
        let mockState = HomeState()
        sut.store.accept(mockState)
        
        XCTAssertEqual(sut.currentState, mockState)
    }
    
    func testInitialLoad() {
        let mockResponse = CharactersResponse.mock(textFilter: nil, page: 1, status: nil)
        
        let expectedState = HomeState(
            characters: mockResponse.results,
            currentPage: mockResponse.info.count + 1,
            pageLimit: mockResponse.info.pages,
            viewState: .loaded,
            nameFilter: nil,
            statusFilter: nil
        )
        
        let expectation = expectation(description: #function)
        let observer = scheduler.createObserver(HomeState.self)
        
        sut.reduce(action: .initialLoad, previousState: HomeState())
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedState])
        XCTAssertEqual(sut.store.value.viewState, .loading)
    }
    
    func testLoadMoreItems() {
        let mockCharacter = CharactersResponse.mock(textFilter: nil, page: 1, status: nil).results.first!
        
        let initialState = HomeState(
            characters: [mockCharacter]
        )
        
        let expectedState = HomeState(
            characters: [mockCharacter, mockCharacter],
            currentPage: 2,
            pageLimit: 10,
            viewState: .loaded
        )
        
        let expectation = expectation(description: #function)
        
        let observer = scheduler.createObserver(HomeState.self)
        
        sut.reduce(action: .loadMoreItems, previousState: initialState)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedState])
    }
    
    func testLoadItemsError() {
        let initialState = HomeState()
        let expectedState = HomeState(viewState: .error)
        
        CurrentEnv.api.fetchCharactersList = { _, _, _ in Observable<CharactersResponse>.error(NSError(domain: "error", code: 1))
        }
        
        let expectation = expectation(description: #function)
        
        let observer = scheduler.createObserver(HomeState.self)
        sut.reduce(action: .initialLoad, previousState: initialState)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedState])
    }
    
    func testChangeFilter() {
        let mockResponse = CharactersResponse.mock(textFilter: "text", page: 1, status: .unknown)
        
        let initialState = HomeState()
        let expectedState = HomeState(
            characters: mockResponse.results,
            currentPage: mockResponse.info.count + 1,
            pageLimit: mockResponse.info.pages,
            viewState: .loaded,
            nameFilter: "text",
            statusFilter: .unknown
        )
        
        let expectation = expectation(description: #function)
        
        let observer = scheduler.createObserver(HomeState.self)
        
        sut.reduce(action: .changeFilter(textFilter: "text", statusFilter: .unknown), previousState: initialState)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedState])
    }

}
