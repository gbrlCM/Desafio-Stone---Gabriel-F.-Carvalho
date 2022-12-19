//
//  UINavigationBar+Style.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 19/12/22.
//

import UIKit

extension UINavigationBar {
    public func applyDefaultStyle() {
        prefersLargeTitles = true
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accent]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accent]
        
    }
}
