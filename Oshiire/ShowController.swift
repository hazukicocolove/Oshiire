//
//  ShowController.swift
//  Oshiire
//
//  Created by Hazuki Tamura on 2021/09/26.
//

import UIKit

class ShowController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
       var selectedImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
