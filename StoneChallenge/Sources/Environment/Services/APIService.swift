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
    
    func fetchCharactersList(name: String? = nil, page: Int = 1, status: RMCharacter.Status? = nil) -> Observable<[RMCharacter]> {
        Observable<[RMCharacter]>.just(Array(repeating: RMCharacter(id: "1", name: "Rick Sanchez", status: .alive, species: "Oi", type: "tipo", gender: "Male", origin: .init(name: "Earth"), localtion: .init(name: "Aqui"), image: URL(string: "https://google.com")!, episode: []), count: 20))
    }
    
    func fetchSingleCharacter(id: String) -> Observable<RMCharacter> {
        fatalError()
    }
    
    func fetchImage(for url: URL?) -> Observable<UIImage?> {
        fatalError()
    }
}
