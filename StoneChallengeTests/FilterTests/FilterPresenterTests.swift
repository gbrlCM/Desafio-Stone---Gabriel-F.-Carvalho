//
//  FilterPresenterTests.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 16/12/22.
//

import XCTest
@testable import StoneChallenge
import RxSwift
import RxTest

final class FilterPresenterTests: XCTestCase {
    
    var sut: FilterPresenter!
    var interactorMock: FilterInteractorMock!
    var coordinatorMock: MainCoordinatorMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        interactorMock = FilterInteractorMock(initialState: FilterState())
        coordinatorMock = MainCoordinatorMock()
        sut = FilterPresenter(interactor: interactorMock)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        CurrentEnv = .mock
        sut.coordinator = coordinatorMock
        
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        scheduler = nil
        disposeBag = nil
        coordinatorMock = nil
    }
    
    func testStatusButtonTapped() {
        sut.statusButtonTapped(.unknown)
        
        XCTAssertEqual(interactorMock.actionsReceived, [.changeStatus(.unknown)])
    }
    
    func testUpdateTextField() {
        sut.updateTextField("Mock value")
        
        XCTAssertEqual(interactorMock.actionsReceived, [.updateText("Mock value")])
    }
    
    func testSearchButtonTapped() {
        let resultSubject = PublishSubject<FilterState>()
        let expectedResult = FilterState(status: .alive, text: nil)
        let observer = scheduler.createObserver(FilterState.self)
        
        interactorMock.stateRelay.accept(expectedResult)
        sut.resultPublish = resultSubject
        
        let expectation = expectation(description: #function)
        
        resultSubject
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        sut.searchButtonTapped()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
        XCTAssertTrue(coordinatorMock.didCallDismiss)
    }
    
    func testViewModelStateBinding() {
        let expectedResult = FilterState(status: .alive, text: "mock")
        let observer = scheduler.createObserver(FilterState.self)
        
        
        let expectation = expectation(description: #function)
        
        interactorMock.stateRelay.accept(expectedResult)
        
        sut
            .viewModel
            .fulfillOnNext(expectation)
            .subscribe(observer)
            .disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(observer.nextEvents, [expectedResult])
    }

}
