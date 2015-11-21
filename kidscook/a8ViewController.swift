//
//  a8ViewController.swift
//  kidscook
//
//  Created by hmhv on 2015/11/20.
//  Copyright © 2015年 hmhv. All rights reserved.
//

import UIKit

class a8ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        
//        var parentVC = presentingViewController
//        while (parentVC?.presentingViewController != nil) {
//            parentVC = parentVC?.presentingViewController
//        }
//        parentVC!.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
