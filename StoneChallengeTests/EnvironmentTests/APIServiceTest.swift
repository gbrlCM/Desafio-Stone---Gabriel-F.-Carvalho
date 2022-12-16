//
//  APIServiceTest.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import XCTest
import RxTest
import RxSwift
@testable import StoneChallenge

final class APIServiceTest: XCTestCase {

    var sut: APIService!
    var fetcherMock: DataFetcherMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        fetcherMock = DataFetcherMock()
        sut = APIService(session: fetcherMock)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        fetcherMock = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testFetchCharacterList() {
        let expectedResult = CharactersResponse.mock(textFilter: nil, page: 1, status: nil)
        let observer = scheduler.createObserver(CharactersResponse.self)
        
        fetcherMock.mockedData[Route.character(page: 1, textFilter: nil, statusFilter: nil).url] = try! JSONEncoder().encode(expectedResult)
        
        let expectation = expectation(description: #function)
        
        sut.fetchCharactersList(name: nil, page: 1, status: nil)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }

}

/*
 "[StoneChallenge.CharactersResponse(info: StoneChallenge.CharactersResponse.Info(count: 1, pages: 10), results: [StoneChallenge.RMCharacter(id: 1, name: "mock ", status: StoneChallenge.RMCharacter.Status.alive, species: "mock", type: "mock", gender: "mock", origin: StoneChallenge.RMCharacter.Origin(name: "mock"), location: StoneChallenge.RMCharacter.Location(name: "mock"), image: file:///mock, episode: [])])]") is not equal to
 ("[StoneChallenge.CharactersResponse(info: StoneChallenge.CharactersResponse.Info(count: 1, pages: 10), results: [StoneChallenge.RMCharacter(id: 1, name: "mock ", status: StoneChallenge.RMCharacter.Status.alive, species: "mock", type: "mock", gender: "mock", origin: StoneChallenge.RMCharacter.Origin(name: "mock"), location: StoneChallenge.RMCharacter.Location(name: "mock"), image: mock -- file:///, episode: [])])]"
 */
