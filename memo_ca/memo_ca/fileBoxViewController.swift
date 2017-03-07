//
//  fileBoxViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/23.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit
import CoreData

class fileBoxViewController: UIViewController {
    
    var scSelectedIndex = ""

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var cardIndex: UITableView!
    @IBOutlet weak var cardCIndex: UITableView!
    
    var indexList:[String] = NSArray() as! [String]
//    var cardCIndex:[String] = NSArray() as! [String]

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
        do {
            // 一括取得
            let fetchResuls = try viewContent.fetch(query)
            // 初期化
            indexList = NSArray() as! [String]
            // 取得
            for result: AnyObject in fetchResuls {
                let front: String? = result.value(forKey: "front") as? String
//                indexList.append(front!)
                print("front:\(front)")
            }
        } catch {
        }
        cardIndex.reloadData()
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
    
    // 行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection Section:Int) -> Int {
        return indexList.count
    }
    // セルの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Call", for: indexPath)
        
        cell.textLabel?.text = "\(indexList[indexPath.row])"
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
