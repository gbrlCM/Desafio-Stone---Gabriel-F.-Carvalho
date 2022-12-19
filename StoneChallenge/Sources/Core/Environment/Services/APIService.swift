//
//  APIService.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import Foundation
import UIKit
import RxSwift

final class APIService {
    
    static let shared = APIService()
    private let session: DataFetcherProtocol
    
    init(session: DataFetcherProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchCharactersList(name: String? = nil, page: Int = 1, status: RMCharacter.Status? = nil) -> Observable<CharactersResponse> {
        session.fetch(from: Route.character(page: page, textFilter: name, statusFilter: status).request)
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
    }
    
    func fetchEpisodes(_ episodesURL: [URL]) -> Observable<[RMEpisode]> {
        Observable
            .zip(episodesURL.map { session.fetch(from: URLRequest(url: $0)) })
            .map { episodesData in
                let jsonDecoder = JSONDecoder()
                
                return try episodesData.map { try jsonDecoder.decode(RMEpisode.self, from: $0) }
            }
    }
}
