//
//  ViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/10.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData
import Social

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var topPageView: UILabel!
    
    @IBOutlet var myImageView: UIView!
//    {
//        myImageView.image = UIImage(named: "ELFAKYUDSC06359_TP_V.jpg")
//    }

    @IBOutlet weak var createNewFile: UIButton!

    @IBOutlet weak var newFileName: UITextField!
    // var newFileName:[String] = NSArray() as! [String]
    
    @IBOutlet weak var indexFiles: UITableView!
    
    var fileList:[String] = NSArray() as! [String]
    var selectedIndex = ""
    
    // TableView行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        // DBの名前
        return fileList.count
    }

    // 選択時に発動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択行を他メンバで使用するためにメンバ変数に保存
        selectedIndex = fileList[indexPath.row]
        performSegue(withIdentifier: "showSecondView", sender: nil)
    }

    // Segueで画面遷移時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面のオブジェクトを作成
        let secondVC = segue.destination as! fileBoxViewController
        // 選択された行番号を次の画面のプロパティに保存
        secondVC.scSelectedIndex = selectedIndex
        print("番号\(secondVC.scSelectedIndex)を次の画面へ渡す。")
    }

    
    
    
    
    
    @IBOutlet weak var fileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // +newFile読み込み
        read()
        
        // キーボードの上にcloseボタンを配置
        // ビューを作成
        let upView = UIView()
        upView.frame.size.height = 60   // 高さを設定
        upView.backgroundColor = UIColor.lightGray
        
        // closeボタンを作成
        let closeButton = UIButton(frame: CGRect(x: self.view.bounds.width - 70, y: 0, width: 70, height: 50))
        closeButton.setTitle("close", for: .normal)
        
        // closeボタンにイベントを設定
//        closeButton.addTarget(self, action: #selector(closekeyboad(sender:)), for: .touchUpInside)
        
        // ビューに閉じるボタンを追加
        upView.addSubview(closeButton)

    }
    
    
    // newFileボタン押した時発動
    @IBAction func newFileName(_ sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // エンティティを操作するためのオブジェクトを作成
        let viewContent = appDelegate.persistentContainer.viewContext
        let Index = NSEntityDescription.entity(forEntityName: "Index", in: viewContent)
        let newRecord = NSManagedObject(entity: Index!, insertInto: viewContent)

        newRecord.setValue(newFileName.text, forKey: "fileName")
        do {
            try viewContent.save()
        } catch {
        }
        read()
}
    


    // 本データ処理
    func read(){
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        // エンティティを操作するためのオブジェクトを作成
        let viewContent = appDelegate.persistentContainer.viewContext
        // どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<Index> = Index.fetchRequest()
        do {
            // データの一括取得
            let fetchResults = try viewContent.fetch(query)
            
            // 一旦配列を空（初期化）にする
            fileList = NSArray() as! [String]
            // データの取得
            for result: AnyObject in fetchResults {
                let title: String? = result.value(forKey: "fileName") as? String
                //print("newFileName:\(newFileName) Index:\(Index)().self()")
                // != ：じゃないとき
                let front: String? = result.value(forKey: "front") as? String
                if front == nil {fileList.append(title!)}
            }
        } catch {
        }
        
        // TableViewの再描画
        indexFiles.reloadData()
    }
    
    
//    // 仮データproArray読み込み。
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return fileList.count
//    }
    
//    var proArray = ["1","2","3","4"]

    // セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! fileBoxCollectionViewCell
        
//        cell.textLabel?.text = fileList[indexPath.row]
        
        cell.fileName.text = fileList[indexPath.row]
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

