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
    var fetchCharactersList: (String?, Int, RMCharacter.Status?) -> Observable<CharactersResponse> = APIService.shared.fetchCharactersList
    var fetchEpisodes: ([URL]) -> Observable<[RMEpisode]> = APIService.shared.fetchEpisodes
}

struct ImageHandler {
    var fetch: (URL) -> Observable<UIImage?> = ImageFetcher.shared.fetch
}

var CurrentEnv = AppEnvironment()
