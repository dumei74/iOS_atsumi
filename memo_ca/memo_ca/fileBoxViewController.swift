//
//  fileBoxViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/23.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData

class fileBoxViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var scSelectedIndex = ""
    
    var scSelectedIndexNumber = -1

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var cardIndex: UITableView!
    @IBOutlet weak var cardCIndex: UITableView!
    
    var indexList:[String] = NSArray() as! [String]
//    var cardCIndex:[String] = NSArray() as! [String]
    
    // TableView行数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        // DBの名前
        return indexList.count
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        if scSelectedIndex != ""{
            fileName.text = scSelectedIndex
        }

        // +new cardの読み込み
        read()
    }

    // 既存Coreデータ読み込み
    func read() {
         let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContent = appDelegate.persistentContainer.viewContext
        let query: NSFetchRequest<Index> = Index.fetchRequest()
        
        
        let namePredicte = NSPredicate(format: "fileName = %@", fileName.text as! CVarArg)
        query.predicate = namePredicte
        do {
            // 一括取得
            let fetchResuls = try viewContent.fetch(query)
            
            
            // 初期化
            indexList = NSArray() as! [String]
            // 取得
            for result: AnyObject in fetchResuls {
                let front: String? = result.value(forKey: "front") as? String
//                indexList.append(front!)
//                print("front:\(front)")
                if front != nil {indexList.append(front!)}
            }
        } catch {
        }
        cardIndex.reloadData()
    }
    
    
    // Segueで画面遷移時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面のオブジェクトを作成
        let secondVC = segue.destination as! memoryViewController
        // 選択された行番号を次の画面のプロパティに保存
        secondVC.scSelectedIndex = scSelectedIndex
        
        secondVC.scSelectedIndexNumber = scSelectedIndexNumber
    }

    
    
    // 削除キー
    @IBAction func tapDelete(_ sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContent = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Index> = Index.fetchRequest()
        do {
            let fetchResults = try viewContent.fetch(request)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject
                // 1行ずつ削除
                viewContent.delete(record)
            }
            // 削除した状態を保存
            try viewContent.save()
            read()
        } catch {
        }
    }
    
//    // 行数の決定
//    func tableView(_ tableView: UITableView, numberOfRowsInSection Section:Int) -> Int {
//        return indexList.count
//    }
    // セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! cardPageCollectionViewCell
        
//        cell.textLabel?.text = "\(indexList[indexPath.row])"

        cell.cardName.text = indexList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scSelectedIndexNumber = indexPath.row
        performSegue(withIdentifier: "showSecondView", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
