//
//  ImageDownloadOperation.swift
//  ImageDownloader
//
//  Created by aton on 2023/03/14.
//

import Foundation
//
class ImageDownloadOperation: Operation {
    private var task: URLSessionDataTask!
    private var urlString: String
    
    init(
        session: URLSession,
        urlString: String,
        completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    ) {
        self.urlString = urlString
        
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        self.task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let completionHandler = completionHandler {
                let random = Int.random(in: 1...2)
                sleep(UInt32(random))
                completionHandler(data, response, error)
            }
        })
    }
    
//    override func main() {
//        super.main()
//        self.task.resume()
//    }
    
    override func start() {
        super.start()
        self.task.resume()
    }
    
    override func cancel() {
        super.cancel()
        self.task.cancel()
    }
}
