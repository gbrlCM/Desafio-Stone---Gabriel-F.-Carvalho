//
//  Rx+Utils.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import RxSwift
import RxTest
import XCTest

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
