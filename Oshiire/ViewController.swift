//
//  ViewController.swift
//  Oshiire
//
//  Created by Hazuki Tamura on 2021/09/13.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // 表示するセルを登録(先程命名した"Cell")
        cell.backgroundColor = .red  // セルの色
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let horizontalSpace : CGFloat = -10
        let cellSize : CGFloat = 1.34*(self.view.bounds.width) / 3
        return CGSize(width: cellSize, height: 86*(cellSize)/72)
        }
    
    // collection viewのoutlet
      @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var imageview: UIImageView!
    
    let imageArray:[UIImage] = []
    var imageIndex:Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
       
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
      
      
    }

    @IBAction func selectPhoto(){
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated:true, completion:nil)
    }
    
    func imagePickerController(_picker:UIImagePickerController,didfinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        let image = info[.originalImage] as? UIImage
        //背景設定
      //  haikeiImageview.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
}

