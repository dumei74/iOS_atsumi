//
//  cardPageViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/21.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import CoreData

class cardPageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var scSelectedIndex = ""

    @IBOutlet var cardPageView: cardPageCollectionViewCell!
    
    
    // カード表示
    @IBOutlet weak var fileName: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var commentCheck: UISwitch!
    @IBOutlet weak var pictureCheckF: UISwitch!
    

    @IBOutlet weak var frontTxt: UITextView!
    @IBOutlet weak var backTxt: UITextView!
    
    @IBOutlet weak var frontView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    var controller: UIImagePickerController! = UIImagePickerController()

    // メンバ変数指定
    var strURLfront: String = ""
    var strURLback: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if scSelectedIndex != ""{
            fileName.text = scSelectedIndex
        }
        
//        // カメラモードの時は写真入力
//        if pictureCheck = on {
//            hidden; frontTxt
//            hidden; backTxt
//        }
        
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
    
    @IBAction func changePictureModeF(_ sender: UISwitch) {
        if sender.isOn {
            frontTxt.isHidden = true
            frontView.isHidden = false
        } else {
            frontView.isHidden = true
            frontTxt.isHidden = false
        }
    }
    
    
    @IBAction func changePictureModeB(_ sender: UISwitch) {
        if sender.isOn {
            backTxt.isHidden = true
            backView.isHidden = false
        } else {
            backView.isHidden = true
            backTxt.isHidden = false
        }
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
//        if (frontTxt.text == "")&&(strURLfront == ""){
//            let alertController = UIAlertController(title: "Warning", message: "Fill in the blank", preferredStyle: .alert)
//            // OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            // アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//
//        }else if strURLfront == ""{
//            let alertController = UIAlertController(title: "Warning", message: "Fill in the blank", preferredStyle: .alert)
//            // OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            // アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//
//        }else if strURLback == ""{
//            let alertController = UIAlertController(title: "Warning", message: "Fill in the blank", preferredStyle: .alert)
//            // OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            // アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//
//        }else if backTxt.text == "" {
//            let alertController = UIAlertController(title: "Warning", message: "Fill in the blank", preferredStyle: .alert)
//            // OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            // アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//        } else {
//            let alertController = UIAlertController(title: "new card added", message: "", preferredStyle: .alert)
//            // OKボタンを追加
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.picOK() }))
//            // アラートを表示する（重要）
//            present(alertController, animated: true, completion: nil)
//        }
        
        
        
        // AppDeligateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        // エンティティオブジェクトの作成
        let Index = NSEntityDescription.entity(forEntityName: "Index", in: viewContext)
        
        // ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成。
        let newRecord = NSManagedObject(entity: Index!, insertInto: viewContext)
        
        // 値のセット
        newRecord.setValue(fileName.text, forKey: "fileName")  // 値を代入
        newRecord.setValue(frontTxt.text, forKey: "front") // 値を代入
        newRecord.setValue(strURLfront, forKey: "frontP")  // 値を代入
        newRecord.setValue(backTxt.text, forKey: "back")  // 値を代入
        newRecord.setValue(strURLback, forKey: "backP")  // 値を代入
//        newRecord.setValue(forKey: "cardNo")  // 値を代入
        do {
            try viewContext.save()
        } catch {
        }
        // TODO:前の画面に戻る
        navigationController?.popViewController(animated: true)
//        read()
    }

    @IBAction func frontImageTaped(_ sender: UITapGestureRecognizer) {
        print ("frontTapしたよ")
        
        controller.delegate = self
        //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //トリミング
        controller.allowsEditing = true
        controller.restorationIdentifier = "front"
        self.present(controller, animated: true, completion: nil)
    }
    
    // image表示
    func imagePickerController(_ imagePicker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if imagePicker.restorationIdentifier == "front" {
            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
            
            strURLfront = assetURL.description
            if strURLfront != ""{
                let url = URL(string: strURLback as String!)
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                let manager: PHImageManager = PHImageManager()
                manager.requestImage(for: asset,targetSize: CGSize(width: 500, height: 500),contentMode: .aspectFit,options: nil) { (image, info) -> Void in
                    self.frontView.image = image
                }
                
            }
        } else {
            let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
            
            strURLback = assetURL.description
            if strURLback != ""{
                let url = URL(string: strURLback as String!)
                let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
                let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
                let manager: PHImageManager = PHImageManager()
                manager.requestImage(for: asset,targetSize: CGSize(width: 500, height: 500),contentMode: .aspectFit,options: nil) { (image, info) -> Void in
                    self.backView.image = image
                }
                
            }
        }
        
        //close
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backImageTaped(_ sender: UITapGestureRecognizer) {
        print ("backtapしたよ")
        controller.delegate = self
        //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //トリミング
        controller.allowsEditing = true
        controller.restorationIdentifier = "back"
        self.present(controller, animated: true, completion: nil)
    }
    
//    // Todo: 入力時のカメラ表示
//    override func viewDidAppear(_ animated: Bool) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
//            //写真ライブラリ(カメラロール)表示用のViewControllerを宣言
//            controller.delegate = self
//            //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
//            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            //トリミング
//            controller.allowsEditing = true
//            //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
//            
//        }
//    }

    
//    //カメラロールで写真を選んだ後
//    func imagePickerController(_ imagePicker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : Any]) {
//        let assetURL:AnyObject = info[UIImagePickerControllerReferenceURL]! as AnyObject
//        
//        strURL = assetURL.description
//        if strURL != ""{
//            let url = URL(string: strURL as String!)
//            let fetchResult: PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [url!], options: nil)
//            let asset: PHAsset = (fetchResult.firstObject! as PHAsset)
//            let manager: PHImageManager = PHImageManager()
//            manager.requestImage(for: asset,targetSize: CGSize(width: 500, height: 500),contentMode: .aspectFit,options: nil) { (image, info) -> Void in
//                self.ImgView.image = image
//            }
//        }
//        
//        //閉じる処理
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
    
    

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

    func picOK(){
//        ImgView.backgroundColor = UIColor.rgb(r: 255, g: 0, b: 0, alpha: 0.1)
//        nameLabel.backgroundColor = UIColor.white
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

