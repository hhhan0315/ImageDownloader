//
//  ImageLoader.swift
//  ImageDownloader
//
//  Created by aton on 2023/03/03.
//

import Foundation

class ImageLoader {
    
    func load(with urlString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return
            }
            completion(data)
        }.resume()
    }
}
