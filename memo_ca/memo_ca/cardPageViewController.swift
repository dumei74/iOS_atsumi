//
//  cardPageViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/21.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData

class cardPageViewController: UIViewController {
    
    @IBOutlet var cardPageView: cardPageCollectionViewCell!
    
    
    // カード表示
    @IBOutlet weak var fileName: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var commentCheck: UISwitch!
    
    
    @IBOutlet weak var frontTxt: UITextView!
    @IBOutlet weak var backTxt: UITextView!
    
    @IBOutlet weak var frontView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    
    
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (Bundle.main)
        
        // キーボードの上にcloseボタンを配置
        // ビューを作成
        let upView = UIView()
        upView.frame.size.height = 60   // 高さを設定
        upView.backgroundColor = UIColor.lightGray
        
        // closeボタンを作成
        let closeButton = UIButton(frame: CGRect(x: self.view.bounds.width - 70, y: 0, width: 70, height: 50))
        closeButton.setTitle("close", for: .normal)
        
        // closeボタンにイベントを設定
        closeButton.addTarget(self, action: #selector(closekeyboad(sender:)), for: .touchUpInside)
        
        // ビューに閉じるボタンを追加
        upView.addSubview(closeButton)
        
        // キーボードのアクセサリービューを設定する
        frontTxt.inputAccessoryView = upView
        backTxt.inputAccessoryView = upView
            
        
    }
    
    
    // キーボードを閉じる
    func closekeyboad(sender: UIButton){
        frontTxt.resignFirstResponder()
        backTxt.resignFirstResponder()
        
        
        // 画面を元に戻す
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            self.cardPageView.frame.origin = CGPoint(x: self.cardPageView.frame.origin.x,y: self.cardPageView.frame.origin.y + 250)
        }, completion: {finished in
        })
    }

    @IBAction func tapSave(_ sender: UIButton) {
        // AppDeligateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // エンティティオブジェクトの作成
        let Index = NSEntityDescription.entity(forEntityName: "Index", in: viewContext)
        
        // ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成。
        let newRecord = NSManagedObject(entity: Index!, insertInto: viewContext)
        
        // 値のセット
        newRecord.setValue(frontTxt.text, forKey: "front") // 値を代入
        newRecord.setValue(backTxt.text, forKey: "back")  // 値を代入
        do {
            // レコード（行）の即時保存
            try viewContext.save()
        } catch {
        }
//        read()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


//    // backTxtにカーソルが当たったとき（入力開始）Sample EditView
//    func backViewShouldBeginEditing(_ backView: UITextView) -> Bool {
//        // フォーム全体を上に移動する
//        UIView.animate(withDuration: 0.2, animations: {() -> Void in
//            self.cardPageView.frame.origin = CGPoint(x: self.view.frame.origin.x,y: self.view.frame.origin.y - 250)
//        }, completion: {finished in print("FormViewが上に移動しました")})
//        
//        // キーボードを表示
//        return true
//    }


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

