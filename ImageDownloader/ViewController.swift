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
    
    @IBOutlet weak var loadButton1: UIButton!
    @IBOutlet weak var loadButton2: UIButton!
    @IBOutlet weak var loadButton3: UIButton!
    @IBOutlet weak var loadButton4: UIButton!
    @IBOutlet weak var loadButton5: UIButton!
    @IBOutlet weak var allLoadButton: UIButton!
    
    var isLoadSuccess1: Bool = false
    var isLoadSuccess2: Bool = false
    var isLoadSuccess3: Bool = false
    var isLoadSuccess4: Bool = false
    var isLoadSuccess5: Bool = false
    
    let group = DispatchGroup()
    
    private let imageLoader = ImageLoader()
    
    let queue = OperationQueue()
    let completionOperation = Operation()
    
    let imageLinks: [String] = [ImageLink.first, ImageLink.second, ImageLink.third, ImageLink.fourth, ImageLink.fifth]
    lazy var imageViews: [UIImageView] = [imageView1, imageView2, imageView3, imageView4, imageView5]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allLoadButton.isEnabled = false
        
        for (index, imageLink) in imageLinks.enumerated() {
            let operation = ImageDownloadOperation(session: URLSession.shared, urlString: imageLink) { data, response, error in
                guard let data = data else {
                    return
                }
                let imageView = self.imageViews[index]
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            queue.addOperation(operation)
            
            operation.completionBlock = {
                print("\(index)번째 이미지 로딩 완료")
            }
            
            completionOperation.addDependency(operation)
        }
        
        completionOperation.completionBlock = {
            print("모두 종료")
            DispatchQueue.main.async {
                self.allLoadButton.isEnabled = true
            }
        }
        
        queue.addOperation(completionOperation)
    }
    
    @IBAction func loadImageView1(_ sender: UIButton) {
        queue.addOperation {
            self.imageLoader.load(with: ImageLink.first) { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView1.image = UIImage(data: data)
                }
            }
        }        
    }
    
    @IBAction func loadImageView2(_ sender: UIButton) {
        queue.addOperation {
            self.imageLoader.load(with: ImageLink.second) { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView2.image = UIImage(data: data)
                }
            }
        }
    }
    
    @IBAction func loadImageView3(_ sender: UIButton) {
        queue.addOperation {
            self.imageLoader.load(with: ImageLink.third) { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView3.image = UIImage(data: data)
                }
            }
        }
    }
    
    @IBAction func loadImageView4(_ sender: UIButton) {
        queue.addOperation {
            self.imageLoader.load(with: ImageLink.fourth) { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView4.image = UIImage(data: data)
                }
            }
        }
    }
    
    @IBAction func loadImageView5(_ sender: UIButton) {
        queue.addOperation {
            self.imageLoader.load(with: ImageLink.fifth) { [weak self] data in
                DispatchQueue.main.async {
                    self?.imageView5.image = UIImage(data: data)
                }
            }
        }
    }
    
    @IBAction func loadAllImages(_ sender: UIButton) {
        [imageView1, imageView2, imageView3, imageView4, imageView5].forEach {
            $0.image = nil
        }
        
        [loadButton1, loadButton2, loadButton3, loadButton4, loadButton5].forEach {
            $0?.sendActions(for: .touchUpInside)
        }
    }
    
    private func checkAllLoadDidEnd() {
        let array = [isLoadSuccess1, isLoadSuccess2, isLoadSuccess3, isLoadSuccess4, isLoadSuccess5]
        if array.filter({ $0 == true }).count == array.count {
            DispatchQueue.main.async {
                self.allLoadButton.isEnabled = true
            }
        }
    }
}

