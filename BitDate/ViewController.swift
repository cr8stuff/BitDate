//
//  ViewController.swift
//  BitDate
//
//  Created by Jamie Montz on 3/31/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRectMake(50.0, 50.0, 200.0, 250.0))
        label.text = "oh ya!"
        
        self.view.addSubview(label)
        self.view.addSubview(CardView(frame: CGRectMake(80.0, 80.0, 120.0, 200.0)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

