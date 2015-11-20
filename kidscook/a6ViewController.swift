//
//  a6ViewController.swift
//  kidscook
//
//  Created by hmhv on 2015/11/20.
//  Copyright © 2015年 hmhv. All rights reserved.
//

import UIKit

class a6ViewController: UIViewController {

    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var shineImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heartImageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        heartImageView.alpha = 0
        shineImageView.alpha = 0
        
        SoundPlayer.play("trumpet.mp3")


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animateWithDuration(1, delay: 0, options: [], animations: { [weak self] () -> Void in
            self?.shineImageView.alpha = 0.7
            }) { (_) -> Void in
        }
        
        
        UIView.animateWithDuration(1.0, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { [weak self] () -> Void in
            self?.heartImageView.transform = CGAffineTransformIdentity
            self?.heartImageView.alpha = 1
            }, completion: nil)
    }
    
}
