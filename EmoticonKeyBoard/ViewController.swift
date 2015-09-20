//
//  ViewController.swift
//  EmoticonKeyBoard
//
//  Created by Jefferson on 15/9/12.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var keyBoard: EmoticonViewController = EmoticonViewController()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputView = keyBoard.view
        
        let viewModel = EmoticonViewModel()
        
        viewModel.loadPackages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        textView.becomeFirstResponder()
    }


}

