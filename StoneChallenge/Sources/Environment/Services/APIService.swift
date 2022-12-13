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
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCharactersList(name: String? = nil, page: Int = 1, status: RMCharacter.Status? = nil) -> Observable<[RMCharacter]> {
        session.rx
            .data(request: Route.character(page: page, textFilter: name, statusFilter: status).request)
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
            .map(\.results)
    }
    
    func fetchSingleCharacter(id: String) -> Observable<RMCharacter> {
        fatalError()
    }
    
    func fetchImage(for url: URL) -> Observable<UIImage?> {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        return session.rx
            .data(request: request)
            .map(UIImage.init(data:))
    }
}

struct CharactersResponse: Codable {
    var results: [RMCharacter]
}
