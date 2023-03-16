//
//  ViewController.swift
//  ImageDownloader
//
//  Created by aton on 2023/03/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    
    @IBOutlet weak var loadLabel1: UILabel!
    @IBOutlet weak var loadLabel2: UILabel!
    @IBOutlet weak var loadLabel3: UILabel!
    @IBOutlet weak var loadLabel4: UILabel!
    @IBOutlet weak var loadLabel5: UILabel!
    
    @IBOutlet weak var allLoadLabel: UILabel!
    
    private lazy var imageTuples: [(imageView: UIImageView, label: UILabel, urlString: String)] = [
        (self.imageView1, self.loadLabel1, ImageLinks.first.rawValue),
        (self.imageView2, self.loadLabel2, ImageLinks.second.rawValue),
        (self.imageView3, self.loadLabel3, ImageLinks.third.rawValue),
        (self.imageView4, self.loadLabel4, ImageLinks.fourth.rawValue),
        (self.imageView5, self.loadLabel5, ImageLinks.fifth.rawValue)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = OperationQueue()
        let completionOperation = Operation()
        
        for (index, item) in imageTuples.enumerated() {
            let operation = ImageDownloadOperation(session: URLSession.shared, urlString: item.urlString) { data, response, error in
                guard let data = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    item.imageView.image = UIImage(data: data)
                }
            }
            queue.addOperation(operation)
            
            operation.completionBlock = {
                print("\(index)번째 이미지 로딩 완료")
                DispatchQueue.main.async {
                    item.label.text = "Load Success!!!"
                }
            }
            
            completionOperation.addDependency(operation)
        }
        
        completionOperation.completionBlock = {
            print("모두 종료")
            DispatchQueue.main.async {
                self.allLoadLabel.text = "All Load Success!!!"
            }
        }
        
        queue.addOperation(completionOperation)
    }
}

