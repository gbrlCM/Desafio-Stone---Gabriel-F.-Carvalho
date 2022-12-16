//
//  UIColor+Assets.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit

extension UIColor {
    
    static var accent: UIColor {
        .color(named: "AccentColor")
    }
    
    private static func color(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            preconditionFailure("Color not found inside the assets")
        }
        return color
    }
}
