//
//  AppEnvironment.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 12/12/22.
//

import Foundation
import UIKit
import RxSwift

struct AppEnvironment {
    var api = API()
    var image = ImageHandler()
}

struct API {
    var fetchCharactersList: (String?, Int, RMCharacter.Status?) -> Observable<[RMCharacter]> = APIService.shared.fetchCharactersList
    var fetchSingleCharacter: (String) -> Observable<RMCharacter> = APIService.shared.fetchSingleCharacter
    var fetchImage: (URL) -> Observable<UIImage?> = APIService.shared.fetchImage
}

struct ImageHandler {
    var fetch: (URL) -> Observable<UIImage?> = ImageFetcher.shared.fetch
}

var CurrentEnv = AppEnvironment()
