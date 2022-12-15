//
//  UICollectionView+Utils.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 14/12/22.
//

import UIKit

extension UICollectionView {
    var didScrollToTheEnd: Bool {
        let contentYOffset = contentOffset.y
        let contentHeight = contentSize.height
        let endTreshold: CGFloat = 70
        
        return contentYOffset > (contentHeight - frame.size.height - endTreshold) && !self.indexPathsForVisibleItems.isEmpty
    }
}
