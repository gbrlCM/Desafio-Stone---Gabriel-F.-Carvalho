//
//  Array+Utils.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
