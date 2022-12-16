//
//  ImageFetcherTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import XCTest
import RxSwift
import RxTest
@testable import StoneChallenge

final class ImageFetcherTests: XCTestCase {
    
    var sut: ImageFetcher!
    var mockSession: DataFetcherMock!
    var cache: NSCache<NSURL, UIImage>!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUp() {
        mockSession = DataFetcherMock()
        cache = NSCache()
        sut = ImageFetcher(session: mockSession, cache: cache)
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        sut = nil
        mockSession = nil
        cache = nil
        disposeBag = nil
        scheduler = nil
    }
    
    func testCacheConfiguration() {
        XCTAssertEqual(cache.totalCostLimit, 100_000_000)
        XCTAssertEqual(cache.countLimit, 150)
    }
    
    func testFetchImageFromSession() {
        let url = URL(string: "https://www.fetchtest.com/sfsymbol")!
        let image = UIImage(systemName: "chevron.down")!
        mockSession.mockedData[url] = image.pngData()!
        
        let expectation = expectation(description: #function)
        
        let testableObserver = scheduler
            .createObserver(Optional<UIImage>.self)
        
        sut
            .fetch(url: url)
            .fulfillOnNext(expectation)
            .subscribe(testableObserver)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(testableObserver.nextEvents.first!)
        XCTAssertNotNil(cache.object(forKey: url as NSURL))
    }
    
    func testFetchImageFromSessionWithIncorrectData() {
        let url = URL(string: "https://www.fetchtest.com/error")!
        mockSession.mockedData[url] = Data()
        
        let expectation = expectation(description: #function)
        
        let observer = scheduler
            .createObserver(Optional<UIImage>.self)
        
        sut
            .fetch(url: url)
            .fulfillAfterError(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.events, [.error(.zero, ImageFetcherError.incorrectData)])
        XCTAssertNil(cache.object(forKey: url as NSURL))
        
    }
    
    func testFetchImageFromCache() {
        let url = URL(string: "https://www.fetchtest.com/sfsymbol")!
        cache.setObject(UIImage(systemName: "chevron.down")!, forKey: url as NSURL)
        
        let expectation = expectation(description: #function)
        
        let observer = scheduler
            .createObserver(Optional<UIImage>.self)
        
        sut
            .fetch(url: url)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(observer.nextEvents[0])
    }
}
