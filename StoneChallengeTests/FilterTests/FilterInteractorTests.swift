//
//  FilterInteractorTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import XCTest
@testable import StoneChallenge
import RxSwift
import RxTest

final class FilterInteractorTests: XCTestCase {
    
    var sut: FilterInteractor!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        sut = FilterInteractor(initialState: FilterState())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        CurrentEnv = .mock
    }
    
    override func tearDown() {
        sut = nil
        scheduler = nil
        disposeBag = nil
    }
    
    func testUpdateText() {
        let expectedResult = FilterState(text: "new value")
        let observer = scheduler.createObserver(FilterState.self)
        
        let expectation = expectation(description: #function)
        
        sut.reduce(action: .updateText("new value"), previousState: FilterState())
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }
    
    func testUpdateStatusToNewValue() {
        let expectedResult = FilterState(status: .dead)
        let observer = scheduler.createObserver(FilterState.self)
        
        let expectation = expectation(description: #function)
        
        sut.reduce(action: .changeStatus(.dead), previousState: FilterState())
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }
    
    func testUpdateStatusToNil() {
        let initialState = FilterState(status: .dead)
        let expectedResult = FilterState(status: nil)
        let observer = scheduler.createObserver(FilterState.self)
        
        let expectation = expectation(description: #function)
        
        sut.reduce(action: .changeStatus(.dead), previousState: initialState)
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }
    
    func testCurrentStateValue() {
        let expectedResult = FilterState(status: .alive, text: "mock")
        sut.store.accept(expectedResult)
        
        XCTAssertEqual(sut.currentState, expectedResult)
    }
    
    func testObservableValue() {
        let expectedResult = FilterState(status: .alive, text: "mock")
        let observer = scheduler.createObserver(FilterState.self)
        sut.store.accept(expectedResult)
        
        let expectation = expectation(description: #function)
        
        sut.observable
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }
    
    func testBind() {
        let expectedResult = FilterState(status: .unknown, text: nil)
        let observer = scheduler.createObserver(FilterState.self)
        
        let expectation = expectation(description: #function)
        
        sut.send(.changeStatus(.unknown))
        
        sut.observable
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }
    
}
