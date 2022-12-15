//
//  ImageFetcher.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 13/12/22.
//

import RxSwift
import UIKit

final class ImageFetcher {
    private let session: DataFetcherProtocol
    private let cache: NSCache<NSURL, UIImage>
    
    static let shared: ImageFetcher = ImageFetcher()
    
    init(session: DataFetcherProtocol = URLSession.shared, cache: NSCache<NSURL, UIImage> = .init()) {
        self.session = session
        self.cache = cache
        configurateCache()
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
            
            return session
                .fetch(from: request)
                .map { data in
                    guard let image = UIImage(data: data) else {
                        throw ImageFetcherError.incorrectData
                    }
                    return image
                }
                .do(onNext: {[weak self] image in
                    guard let image else { return }
                    self?.cache.setObject(image, forKey: url as NSURL)
                })
        }
    }
}

enum ImageFetcherError: Error {
    case incorrectData
}
