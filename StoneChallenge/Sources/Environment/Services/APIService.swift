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
    
    func fetchCharactersList(name: String? = nil, page: Int = 1, status: RMCharacter.Status? = nil) -> Observable<RMCharacter> {
        fatalError()
    }
    
    func fetchSingleCharacter(id: String) -> Observable<RMCharacter> {
        fatalError()
    }
    
    func fetchImage(for url: URL?) -> Observable<UIImage?> {
        fatalError()
    }
}
