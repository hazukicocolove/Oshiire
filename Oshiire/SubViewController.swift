//
//  SubViewController.swift
//  Oshiire
//
//  Created by Hazuki Tamura on 2021/09/26.
//

import Foundation
import UIKit
 
class SubViewController: UIViewController{
    @IBOutlet var imageView: UIImageView!
       var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = selectedImg
               // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
               imageView.contentMode = UIView.ContentMode.scaleAspectFit
    }
}
