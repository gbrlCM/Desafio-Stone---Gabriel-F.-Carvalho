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
    
    func testFetchCharacterEpisodes() {
        let urls: [URL] = [URL(string: "https://www.mock.com/ep/1")!, URL(string: "https://www.mock.com/ep/2")!, URL(string: "https://www.mock.com/ep/3")!]
        let episodes = urls.map { RMEpisode(id: 0, name: $0.absoluteString, episode: $0.absoluteString, airDate: $0.absoluteString) }
        zip(urls, episodes).forEach { url, episode in fetcherMock.mockedData[url] = try! JSONEncoder().encode(episode) }
        
        let observer = scheduler.createObserver([RMEpisode].self)
        
        let expectation = expectation(description: #function)
        
        sut.fetchEpisodes(urls)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents.first!, episodes)
    }

}
