//
//  ViewController.swift
//  Oshiire
//
//  Created by Hazuki Tamura on 2021/09/13.
//

import UIKit
import RealmSwift
import Photos


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // picturesの配列の中身の数を表示する
       return itemList.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Main.StoryboardのCellを探してくる
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
      
           // imageViewに写真を表示
        cell.shashin.image = UIImage(data: itemList[indexPath.row].realmUse as Data)
           // Labelにタイトルを表示
        //   cell.titleLabel.text = shootingDate[indexPath.row].title
        
        
        // 表示するセルを登録(先程命名した"Cell")
        cell.backgroundColor = .white  // セルの色
        // 例としてカスタムセルそのものに影と角丸をつける
                   cell.layer.masksToBounds = false
                   cell.layer.shadowColor = UIColor.black.cgColor
                   cell.layer.shadowOpacity = 0.2
                   cell.layer.shadowRadius = 4
                   cell.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        //セルのラベルに番号を設定する。
             cell.label.text = String(indexPath.row + 1)
        
      //array//  var array = userDefaults.array(forKey: "キー")
    
        colorlilter1()
        func colorlilter1(){
        //ネット
    //    self.test.image = UIImage(named: "242486518_249743123732507_5928410061423618941_n")

               let filteredImage = CIImage(image: cell.shashin.image!)
               let filter = CIFilter(name: "CIColorControls")

               filter!.setValue(filteredImage, forKey: "inputImage")
        //7
        filter!.setValue(3.2, forKey: "inputContrast")
        filter!.setValue(1.0, forKey: "inputBrightness")
            
               self.ciContext = CIContext(options: nil)
        let imageRef = self.ciContext.createCGImage((filter?.outputImage)!, from: (filter?.outputImage!.extent)!)
        let outputImage = UIImage(cgImage: imageRef!)
            cell.shashin.image = outputImage
            print("oo")
        }
  
        //cellに適用
        return cell
    }
    
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let horizontalSpace : CGFloat = -10
        let cellSize : CGFloat = 1.34*(self.view.bounds.width) / 3
        
        return CGSize(width: cellSize, height: 86*(cellSize)/72)
       
        }
    
    var selectedImage: UIImage?
    
    // collection viewのoutlet
      @IBOutlet var collectionView: UICollectionView!
   
   //☆
    var itemList: Results<Use>!
    
    //元画像
    var originalImage:UIImage!
 
    //フィルターインスタンス
    var filter:CIFilter!
    var ciImage: CIImage!
    
    var userDefaults = UserDefaults.standard
    
    
    @IBOutlet weak var  deleteButton: UIButton!
   
        //ネット
   @IBOutlet var test: UIImageView!
    var ciContext: CIContext!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Realmの初期化
        let realm = try! Realm()
        // Realmから保存されている写真のデータを取得
        itemList = realm.objects(Use.self)
        // CollectionViewを更新
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
       
       
      
       
        
      
       
    //☆
        let realm = try! Realm()
        itemList = realm.objects(Use.self)
        
         self.collectionView.reloadData()
        
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
        print("a")
        self.present(imagePickerController, animated:true, completion:nil)
    }
    
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   print("aaa")
           // [indexPath.row] から画像名を探し、UImage を設定
           selectedImage =  UIImage(data: itemList[indexPath.row].realmUse as Data)
           if selectedImage != nil {
               // SubViewController へ遷移するために Segue を呼び出す
               performSegue(withIdentifier: "toSubViewController",sender: nil)
           }
       }
    
       // Segue 準備
       override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
           if (segue.identifier == "toSubViewController") {
               let subVC: SubViewController = (segue.destination as? SubViewController)!
    
               // SubViewController のselectedImgに選択された画像を設定する
               subVC.selectedImg = selectedImage
           }
       }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               print("b")
                let image = info[.originalImage] as? UIImage
//                 originalImage = image.image!
       
     //   var array : [UIImage?] = []
      //  array.insert(image, at: 0)
        
    
//array//        var array = userDefaults.array(forKey: "キー") as? [UIImage?] ?? []
//        array.insert(image, at: 0)
//        userDefaults.set(array, forKey: "キー")
//
        
        // 写真を変換
        let realmUse = NSData(data: image!.jpegData(compressionQuality: 0.9)!)
      
            //    imageArray.append(image!)
                // cell.shashin = image
        
        // Realmにデータを保存する
        let use = Use()
      //  use.realmUse = image?.NSData()
        let realm = try! Realm()
     
        if let useList = realm.object(UseList.self).first{
            useList.uses.insert(use, at: 0)
        }else{
        
        
        // Add a new item to it
        let newUse = Use()
        newUse.realmUse = NSData()
        }
               try! realm.write{
                   realm.add(use)
                   
                   // Add a new item to it
                  
                   use.realmUse = NSData()

               //    try! realm.write {
//                      useList.uses.insert(use, at: 0)
               //    realmUse.insert(use, at: 0)
                      // 写真を設定
                      use.realmUse = realmUse
                      // 写真の説明を設定
                    //  pictureData.date = "Test"
                      // Realmにデータを書き込む
                    
                  

                       /*/にちじ
                        var shootingDate: String = ""    // 撮影日時
                        // 日時の表示形式はお好みで
                           let formatter = DateFormatter()
                           formatter.timeZone = TimeZone.current
                           formatter.locale = Locale.current
                           formatter.dateFormat = "yyyy-MM-dd"
                           guard let asset = info[.phAsset] as? PHAsset else { return }
                           shootingDate = formatter.string(from: asset.creationDate!)
                           print("shootingDate: \(shootingDate)")
                   
                        *///にちじ
                   
                          collectionView.reloadData()
                self.dismiss(animated: true, completion: nil)
        
    
 //   }
}
    }
        @IBAction func delete(){
          
            if itemList == nil{
                deleteButton.isEnabled = true
            }else{
            //UIButtonを無効化
                deleteButton.isEnabled = false
            }
            
            // アラートダイアログを生成
            let alertController = UIAlertController(title: "お掃除",
                                                    message: "押し入れを空にする",
                                                    preferredStyle: UIAlertController.Style.alert)
            // OKボタンがタップされた時の処理
            let okAction = UIAlertAction(title: "OK",
                                         style: UIAlertAction.Style.default, handler: { action in
                                            // OKボタンがタップされた時の処理
                // (1)Realmインスタンスの生成
                let realm = try! Realm()
                // (2)全データの削除
                try! realm.write {
                    realm.deleteAll()
                }
                self.collectionView.reloadData()
            
                                            print("OKボタンがタップされた")
            })
            // OKボタンを追加
            alertController.addAction(okAction)

            // CANCELボタンがタップされた時の処理
            let cancelButton = UIAlertAction(title: "キャンセル",
                                             style: UIAlertAction.Style.cancel, handler: { action in
                                                // CANCELボタンがタップされた時の処理
                                                print("CANCELボタンがタップされた")
            })
            // CANCELボタンを追加
            alertController.addAction(cancelButton)
            // アラートダイアログを表示
            present(alertController, animated: true, completion: nil)
        }
    
 
    /*     func colorFilter(){
        
       // viewImage.image = UIImage(named: "IMG_3368")

//           let filteredImage = CIImage(image: self.viewImage.image!)
//           let filter = CIFilter(name: "CIVignette")


       let filterImage:CIImage = CIImage(image: originalImage)!
        
        //フィルター設定
        filter = CIFilter(name: "CIColorControls")!
        //彩度の設定
        filter.setValue(1.0, forKey: "inputSaturation")
        //明度
        filter.setValue(0.5, forKey: "inputBrightness")
        //コントラスト
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let CIImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        image.image = UIImage(cgImage: CGImage!)
   */
    
    
    /*こっちにメソッド作りたかった
     func colorlilter(){
    //ネット
    self.test.image = UIImage(named: "242486518_249743123732507_5928410061423618941_n")

           let filteredImage = CIImage(image: self.test.image!)
           let filter = CIFilter(name: "CIColorControls")

           filter!.setValue(filteredImage, forKey: "inputImage")
    filter!.setValue(3.2, forKey: "inputContrast")
    filter!.setValue(1.0, forKey: "inputBrightness")

           self.ciContext = CIContext(options: nil)
    let imageRef = self.ciContext.createCGImage((filter?.outputImage)!, from: (filter?.outputImage!.extent)!)
    let outputImage = UIImage(cgImage: imageRef!)
        self.test.image = outputImage
        
    }
    */
}


//6
//filter!.setValue(2.8, forKey: "inputContrast")
//filter!.setValue(0.875, forKey: "inputBrightness")
//5
//filter!.setValue(2.4, forKey: "inputContrast")
//filter!.setValue(0.75, forKey: "inputBrightness")
//4
//filter!.setValue(2.0, forKey: "inputContrast")
//filter!.setValue(0.625, forKey: "inputBrightness")
//3
//filter!.setValue(1.6, forKey: "inputContrast")
//filter!.setValue(0.5, forKey: "inputBrightness")
//2
//filter!.setValue(1.2, forKey: "inputContrast")
//filter!.setValue(0.375, forKey: "inputBrightness")
//1
//filter!.setValue(0.8, forKey: "inputContrast")
//filter!.setValue(0.25, forKey: "inputBrightness")
//0
//filter!.setValue(0.4, forKey: "inputContrast")
//filter!.setValue(0,125 forKey: "inputBrightness")
