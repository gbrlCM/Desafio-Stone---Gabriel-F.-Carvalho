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
}

struct API {
    var fetchCharactersList: (String?, Int, RMCharacter.Status?) -> Observable<RMCharacter> = APIService.shared.fetchCharactersList
    var fetchSingleCharacter: (String) -> Observable<RMCharacter> = APIService.shared.fetchSingleCharacter
    var fetchImage: (URL?) -> Observable<UIImage?> = APIService.shared.fetchImage
}

var CurrentEnv = AppEnvironment()
