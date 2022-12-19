//
//  EnvironmentMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import RxSwift
import UIKit
@testable import StoneChallenge

extension AppEnvironment {
    static var mock: AppEnvironment {
        AppEnvironment(
            api: .mock,
            image: .mock
        )
    }
}

extension API {
    static var mock: API {
        API(
            fetchCharactersList: { text, page, status in
                Observable<CharactersResponse>
                    .just(
                        .mock(
                            textFilter: text,
                            page: page,
                            status: status
                        )
                    )
            },
            fetchEpisodes: { urls in
                Observable<[RMEpisode]>
                    .just(
                        RMEpisode.mock(for: urls)
                    )
            }
        )
    }
}

extension ImageHandler {
    static var mock: ImageHandler {
        ImageHandler(
            fetch: { url in Observable<UIImage?>.just(ImageReferences.mock) }
        )
    }
}
