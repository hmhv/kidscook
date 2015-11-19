//
//  ViewController.swift
//  kidscook
//
//  Created by hmhv on 2015/11/17.
//  Copyright © 2015年 hmhv. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var logo1ImageView: DesignableImageView!
    @IBOutlet weak var logo2ImageView: DesignableImageView!
    @IBOutlet weak var startButton: DesignableButton!
    
    var timer: NSTimer? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateLogo()
        animateButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animateLogo", userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }
    
    func animateLogo() {
        logo1ImageView.delay = 1
        logo1ImageView.duration = 1
        logo1ImageView.animation = "swing"
        logo1ImageView.animate()
    }

    func animateButton() {
        startButton.duration = 1
        startButton.animation = "zoomIn"
        startButton.animate()
    }

    @IBAction func startButtonTapped(sender: AnyObject) {
        
    }

    
}

