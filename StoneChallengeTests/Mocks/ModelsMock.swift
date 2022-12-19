//
//  ModelsMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

@testable import StoneChallenge
import Foundation
import UIKit

extension CharactersResponse {
    static func mock(textFilter: String?, page: Int, status: RMCharacter.Status?) -> CharactersResponse {
        CharactersResponse(
            info: .init(count: page, pages: 10),
            results: [
                RMCharacter(
                    id: 1,
                    name: "mock \(textFilter ?? "")",
                    status: status ?? .alive,
                    species: "mock",
                    type: "mock",
                    gender: "mock",
                    origin: .init(name: "mock"),
                    location: .init(name: "mock"),
                    image: URL(string: "https://mock.com/mock")!,
                    episode: [
                        URL(string: "https://www.mock.com/episode/1")!,
                        URL(string: "https://www.mock.com/episode/2")!,
                        URL(string: "https://www.mock.com/episode/3")!,
                    ])
            ]
            )
    }
}

extension RMEpisode {
    
    static func mock(for urls: [URL]) -> [RMEpisode] {
        urls.map { RMEpisode(id: 0, name: $0.absoluteString, episode: $0.absoluteString, airDate: $0.absoluteString) }
    }
}

extension RMCharacter {
    static var mock: RMCharacter {
        RMCharacter(
            id: 1,
            name: "name",
            status: .alive,
            species: "species",
            type: "type",
            gender: "gender",
            origin: .init(name: "origin"),
            location: .init(name: "location"),
            image: URL(string: "https://www.mock.com/image/1")!,
            episode: [
                URL(string: "https://www.mock.com/episode/1")!,
                URL(string: "https://www.mock.com/episode/2")!,
                URL(string: "https://www.mock.com/episode/3")!
            ])
    }
}

enum ImageReferences {
    static let mock = UIImage(systemName: "chevron.down")
}
