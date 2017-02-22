//
//  cardPageCollectionViewCell.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/02/21.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit



class cardPageCollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var frontTxt: UITextView!
    
    @IBOutlet weak var backTxt: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var hideBtn: UIButton!
}
