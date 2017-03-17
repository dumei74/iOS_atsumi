//
//  memoryViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/03/14.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData

class memoryViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var scSelectedIndex = ""
    var scSelectedIndexNumber = -1
    var indexList:[NSDictionary]! = []

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var surface: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var word: UITextView!
    @IBOutlet weak var tapHide: UIButton!

//    indexList.add(front.text)
//
//    // CoreDataの内容を持ってきた
//    indexList.add(["front":front.txt,"frontP":frontP.image,"back":back.txt,"backP":back.image])
//    
//    indexList = [["front","frontP","back","backP"],["front","frontP","back","backP"]]
//    
//

    override func viewDidLoad() {
        super.viewDidLoad()

//        indexList = ["front","frontP","back","backP"]
//        var myDedault = UserDefaults.standard
//        
//        var appDomain:Dictionary = Bundle.main.bundleIdentifier!
//
//        // word
////        if scSelectedIndex != ""{
////            word.text = scSelectedIndex
//        if (myDefault.object(forKey: "indexList") != nil){
//            
//            // 「取り出した結果がnilじゃなかったら、」
//            // データを呼び出して
//            indexList = NSMutableArray(array:myDefault.object(forKey: "indexList") as! NSMutableArray)
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("scSelectedIndexNumber:\(scSelectedIndexNumber)")
        read()
        
        
        
        // fileName
        if scSelectedIndex != ""{
            fileName.text = scSelectedIndex
            surface.text = "front"
        } else if scSelectedIndex != ""{
            surface.text = "back"
        }
    }

    // 読み取り
    func read() {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContent = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Index> = Index.fetchRequest()
        
        
        let namePredicte = NSPredicate(format: "fileName = %@", fileName.text as! CVarArg)
        query.predicate = namePredicte
        do {
            // 一括取得
            let fetchResuls = try viewContent.fetch(query)
            indexList = []
            for result: AnyObject in fetchResuls {
                
                
                
                
                let front: String? = result.value(forKey: "front") as? String
                
                
                
                if front != nil {
                    //保存するディクショナリーを作成
                    var dic: NSDictionary? = ["front":result.value(forKey: "frontP"),"frontP":result.value(forKey: "frontP"),"back":result.value(forKey: "back"),"backP":result.value(forKey: "backP")]
                    
                    // ディクショナリーを配列に追加
                    
                    indexList.append(dic!)
                
                }
            }
        } catch {
        }
    }

    
    @IBAction func tapTurn(_ sender: UITapGestureRecognizer) {
        print ("ターン")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
