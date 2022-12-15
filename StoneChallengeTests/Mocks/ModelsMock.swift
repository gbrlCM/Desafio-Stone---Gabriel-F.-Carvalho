//
//  ModelsMock.swift
//  StoneChallengeTests
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

@testable import StoneChallenge
import Foundation

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
                    image: URL(fileURLWithPath: "mock"),
                    episode: [])
            ]
            )
    }
}
