//
//  ImageDownloadOperation.swift
//  ImageDownloader
//
//  Created by aton on 2023/03/14.
//

import Foundation

class ImageDownloadOperation: Operation {
    private var task: URLSessionDataTask?
    private var urlString: String
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is\(rawValue.capitalized)"
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override var isReady: Bool {
        return super.isReady && self.state == .ready
    }
    
    override var isExecuting: Bool {
        return self.state == .executing
    }
    
    override var isFinished: Bool {
        return self.state == .finished
    }
    
    init(
        session: URLSession,
        urlString: String,
        completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    ) {
        self.urlString = urlString
        super.init()
        
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        self.task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let completionHandler = completionHandler {
                let random = Int.random(in: 1...2)
                sleep(UInt32(random))
                self.state = .finished
                completionHandler(data, response, error)
            }
        })
    }
    
    override func main() {
        if isCancelled {
            self.state = .finished
            return
        }
        
        self.task?.resume()
    }
    
    override func cancel() {
        super.cancel()
        
        self.task?.cancel()
        self.state = .finished
    }
}
