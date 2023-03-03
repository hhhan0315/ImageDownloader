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
    
    private let imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loadImageView1(_ sender: UIButton) {
        imageView1.image = nil
        imageLoader.load(with: ImageLink.first) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView1.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func loadImageView2(_ sender: UIButton) {
        imageView2.image = nil
        imageLoader.load(with: ImageLink.second) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView2.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func loadImageView3(_ sender: UIButton) {
        imageView3.image = nil
        imageLoader.load(with: ImageLink.third) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView3.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func loadImageView4(_ sender: UIButton) {
        imageView4.image = nil
        imageLoader.load(with: ImageLink.fourth) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView4.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func loadImageView5(_ sender: UIButton) {
        imageView5.image = nil
        imageLoader.load(with: ImageLink.fifth) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView5.image = UIImage(data: data)
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
}

