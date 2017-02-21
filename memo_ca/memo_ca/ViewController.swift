//
//  ViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/10.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var topPageView: UILabel!
    
    @IBOutlet var myImageView: UIView!
//    {
//        myImageView.image = UIImage(named: "ELFAKYUDSC06359_TP_V.jpg")
//    }

    @IBOutlet weak var createNewFile: UIButton!

    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var indexFiles: UITableView!
    
    var fileList:[String] = NSArray() as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // +newFile読み込み
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
                let title: String? = result.value(forKey: "title") as? String
                let saveData: Date? = result.value(forKey: "saveData") as? Date
                
                print("title:\(title) saveDate:\(saveData)")
                
                fileList.append(title!)
            }
        } catch {
        }
        
        // TableViewの再描画
        indexFiles.reloadData()
    }
    
    
    // 仮データproArray読み込み。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proArray.count
    }
    
    var proArray = ["1","2","3","4"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = proArray[indexPath.row]
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

