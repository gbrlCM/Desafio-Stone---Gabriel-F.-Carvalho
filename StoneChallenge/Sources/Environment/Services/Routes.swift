//
//  Routes.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import Foundation

enum Route {
    static func character(page: Int, textFilter: String?, statusFilter: RMCharacter.Status?) -> Endpoint {
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        let textFilter = URLQueryItem(name: "name", value: textFilter)
        let statusFilter = URLQueryItem(name: "status", value: statusFilter?.rawValue)
        
        return Endpoint(path: "character", queryItems: [pageQueryItem, textFilter, statusFilter])
    }
}
