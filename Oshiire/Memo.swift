//
//  Memo.swift
//  Oshiire
//
//  Created by Hazuki Tamura on 2021/09/20.
//

import Foundation
import RealmSwift
import UIKit

class UseList: Object {
   let uses = List<Use>()
}

class Use: Object {
    @objc dynamic var realmUse: NSData!
    // 写真の説明を保存するtitle
    @objc dynamic var date = ""
    
    dynamic var productName = ""
    
       //Listの定義
    //var itemList: Results<TodoModel>!
}
//    class Memo: Object {
//        @objc dynamic var memoTitle: String = ""
//    }
    // var itemList: Results<Memo>!let realm = try! Realm()

let realm = try! Realm()

// Get the list object
//let useList = realm.objects(UseList.self).first!

// Add a new item to it
//let newUse = Use()
//newUse.productName = "Item Name"
//
//try! realm.write {
//  useList.uses.insert(newUse, at: 0)
//}




//class numnum: Object {
//    let bangou = List<numnum>()
//}
