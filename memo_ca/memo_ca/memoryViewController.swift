//
//  memoryViewController.swift
//  memo_ca
//
//  Created by 石井篤美 on 2017/03/14.
//  Copyright © 2017年 石井篤美. All rights reserved.
//

import UIKit

class memoryViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var scSelectedIndex = ""
    var scSelectedIndexNumber = -1

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var surface: UILabel!
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var word: UITextView!
    @IBOutlet weak var tapHide: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("scSelectedIndexNumber:\(scSelectedIndexNumber)")
        
        // fileName
        if scSelectedIndex != ""{
            fileName.text = scSelectedIndex
        }

//        // word
//        if scSelectedIndex != ""{
//            word.text = scSelectedIndex
//        }
    }
    
    
    
    @IBAction func tapTurn(_ sender: UITapGestureRecognizer) {
        print ("ターン")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
