//
//  DataFetcherMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation
import RxSwift
@testable import StoneChallenge

final class DataFetcherMock: DataFetcherProtocol {
    var mockedData: [URL: Data] = [:]
    
    func fetch(from request: URLRequest) -> RxSwift.Observable<Data> {
        Observable<Data>.just(mockedData[request.url!]!)
    }
}

