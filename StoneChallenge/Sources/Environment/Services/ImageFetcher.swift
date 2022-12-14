//
//  ImageFetcher.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import RxSwift
import UIKit

final class ImageFetcher {
    private let session: URLSession
    private let cache: NSCache<NSURL, UIImage>
    
    static let shared: ImageFetcher = ImageFetcher()
    
    init(session: URLSession = .shared, cache: NSCache<NSURL, UIImage> = .init()) {
        self.session = session
        self.cache = cache
    }
    
    private func configurateCache() {
        cache.countLimit = 150
        cache.totalCostLimit = 100_000_000
    }
    
    func fetch(url: URL) -> Observable<UIImage?> {
        if let image = cache.object(forKey: url as NSURL) {
            return Observable<UIImage?>.just(image)
        } else {
            let request = URLRequest(url: url)
            
            return session.rx
                .data(request: request)
                .map(UIImage.init(data:))
                .do(onNext: {[weak self] image in
                    guard let image else { return }
                    self?.cache.setObject(image, forKey: url as NSURL)
                })
        }
    }
}
