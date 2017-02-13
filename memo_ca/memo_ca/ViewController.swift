//
//  ViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/10.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topPageView: UILabel!
    
    @IBOutlet var myImageView: UIView!
//    {
//        myImageView.image = UIImage(named: "ELFAKYUDSC06359_TP_V.jpg")
//    }
    
    @IBOutlet weak var createNewFile: UIButton!
    
    @IBOutlet weak var indexFiles: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

