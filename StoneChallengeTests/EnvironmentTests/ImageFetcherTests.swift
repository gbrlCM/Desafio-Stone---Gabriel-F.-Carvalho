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
        var url = URL(string: "https://www.fetchtest.com/sfsymbol")!
        var image = UIImage(systemName: "chevron.down")!
        mockSession.mockedData[url] = image.pngData()!
        
        var expectation = expectation(description: #function)
        
        var testableObserver = scheduler
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
        var url = URL(string: "https://www.fetchtest.com/error")!
        mockSession.mockedData[url] = Data()
        
        var expectation = expectation(description: #function)
        
        var observer = scheduler
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
        var url = URL(string: "https://www.fetchtest.com/sfsymbol")!
        cache.setObject(UIImage(systemName: "chevron.down")!, forKey: url as NSURL)
        
        var expectation = expectation(description: #function)
        
        var observer = scheduler
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

extension TestableObserver {
    var nextEvents: [Element] {
        return events.compactMap {
            guard case let .next(value) = $0.value else {
                return nil
            }
            return value
        }
    }
    
    
}

extension Observable {
    func fulfillOnNext(_ expectation: XCTestExpectation) -> Observable<Element> {
        self.do(onNext: { _ in expectation.fulfill() })
    }
    
    func fulfillAfterCompletion(_ expectation: XCTestExpectation) -> Observable<Element> {
        self.do(afterCompleted: {  expectation.fulfill() })
    }
    
    func fulfillAfterError(_ expectation: XCTestExpectation) -> Observable<Element> {
        self.do(afterError: { _ in expectation.fulfill() })
    }
}
