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
    
    // カード表示
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var frontView: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!


    // closeボタン
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        
        // ビューに閉じるボタンを追加
        upView.addSubview(closeButton)
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
