//
//  FTImageDownloader.swift
//  FTWebImage
//
//  Created by LiuFengting on 2024/4/1.
//

import UIKit

public enum FTWebImageError: Error {
    case generic
}

public extension UIImageView {
    
    func loadImage(fromURL: URL?, completion:  ((Error?) -> Void)?) {
        FTImageDownloader.shared.loadImage(fromURL: fromURL) { image, error in
            if let image = image {
                self.image = image
                completion?(nil)
            } else if let error = error {
                completion?(error)
            } else {
                completion?(FTWebImageError.generic)
            }
        }
    }
    
}

public extension UIButton {
    
    func loadImage(fromURL: URL?, for state: UIButton.State, completion:  ((Error?) -> Void)?) {
        FTImageDownloader.shared.loadImage(fromURL: fromURL) { image, error in
            if let image = image {
                self.setImage(image, for: state)
                completion?(nil)
            } else if let error = error {
                completion?(error)
            } else {
                completion?(FTWebImageError.generic)
            }

        }
    }
    
}

public class FTImageDownloader {
    
    static let shared = FTImageDownloader()
    private var cache = FTWebImageCache<String, UIImage>(capacity: 5000)
    
    
    func loadImage(fromURL url: URL?, completion: ((UIImage?, Error?) -> Void)?) {
        guard let url = url else {
            DispatchQueue.main.async {
                completion?(nil, FTWebImageError.generic)
            }
            return
        }
        print(url)
        if let cachedImage = cache.object(forKey: url.absoluteString) {
            DispatchQueue.main.async {
                completion?(cachedImage, nil)
            }
            cache.updateKeyAccessTime(forKey: url.absoluteString)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
                return
            }
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data) {
                    print(downloadedImage.size)
                    self.cache.setObject(downloadedImage, forKey: url.absoluteString)
                    completion?(downloadedImage, nil)
                } else {
                    completion?(nil, FTWebImageError.generic)
                }
            }
        }.resume()
    }
    
}

public class FTWebImageCache<Key: Hashable, Value> {
    
    private var capacity: Int
    private var cache: [Key: Value]
    private var accessTimes: [Key: Date]
    
    init(capacity: Int) {
        self.capacity = capacity
        self.cache = [:]
        self.accessTimes = [:]
    }
    
    func setObject(_ object: Value, forKey key: Key) {
        if cache.count >= capacity, let leastUsedKey = accessTimes.min(by: { $0.value < $1.value })?.key {
            cache.removeValue(forKey: leastUsedKey)
            accessTimes.removeValue(forKey: leastUsedKey)
        }
        cache[key] = object
        accessTimes[key] = Date()
    }
    
    func object(forKey key: Key) -> Value? {
        if let value = cache[key] {
            accessTimes[key] = Date()
            return value
        }
        return nil
    }
    
    func updateKeyAccessTime(forKey key: Key) {
        accessTimes[key] = Date()
    }
    
    func removeAllObjects() {
        cache.removeAll()
        accessTimes.removeAll()
    }
    
}
