//
//  UIImage+Color.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 15/12/22.
//

import UIKit

extension UIImage {
    static func color(_ color: UIColor) -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
