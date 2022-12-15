//
//  DataFetcher.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import Foundation
import RxSwift

protocol DataFetcherProtocol {
    func fetch(from request: URLRequest) -> Observable<Data>
}

extension URLSession: DataFetcherProtocol {
    func fetch(from request: URLRequest) -> Observable<Data> {
        self.rx.data(request: request)
    }
}
