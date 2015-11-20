//
//  CupViewController.swift
//  kidscook
//
//  Created by hmhv on 2015/11/17.
//  Copyright © 2015年 hmhv. All rights reserved.
//

import UIKit

class CupViewController: UIViewController {

    @IBOutlet weak var namiMizuImageView: UIImageView!
    @IBOutlet weak var hiraMizuImageView: UIImageView!
    @IBOutlet weak var drop1ImageView: UIImageView!
    @IBOutlet weak var drop2ImageView: DesignableImageView!
    @IBOutlet weak var drop3ImageView: DesignableImageView!
    @IBOutlet weak var drop4ImageView: DesignableImageView!
    @IBOutlet weak var niceImageView: DesignableImageView!
    
    var timer: NSTimer? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        niceImageView.alpha = 0

        hiraMizuImageView.alpha = 0
        
        drop1ImageView.alpha = 0
        drop2ImageView.alpha = 0
        drop3ImageView.alpha = 0
        drop4ImageView.alpha = 0
        
    }

    func startAnimation() {
        
        UIView.animateWithDuration(1.0, delay: 0, options: [], animations: { [weak self] () -> Void in
            self?.drop1ImageView.alpha = 1
            self?.drop2ImageView.alpha = 1
            self?.drop3ImageView.alpha = 1
            self?.drop4ImageView.alpha = 1
            }) { (_) -> Void in
        }
        
        UIView.animateWithDuration(5.0, delay: 0, options: [], animations: { [weak self] () -> Void in
            self?.namiMizuImageView.frame.origin.y = -10.0
            }) { [weak self] (_) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self?.namiMizuImageView.frame.origin.y = 0.0
                    self?.hiraMizuImageView.alpha = 1
                    }, completion: { (_) -> Void in
                        UIView.animateWithDuration(1, animations: { () -> Void in
                            
                            self?.drop1ImageView.alpha = 0
                            self?.drop2ImageView.alpha = 0
                            self?.drop3ImageView.alpha = 0
                            self?.drop4ImageView.alpha = 0
                            
                            if let timer = self?.timer {
                                timer.invalidate()
                            }
                            self?.timer = nil

                            }, completion: { (_) -> Void in
                                UIView.animateWithDuration(1, animations: { () -> Void in
                                    
                                    self?.niceImageView.alpha = 1
                                    
                                    }, completion: { (_) -> Void in
                                        UIView.animateWithDuration(2.0, delay: 0, options: [], animations: { () -> Void in

                                            self?.niceImageView.animation = "wobble"
                                            self?.niceImageView.animate()
                                            
                                            }) { (_) -> Void in
                                                self?.performSegueWithIdentifier("HeartSegue", sender: nil)
                                        }
                                })
                        })
                })
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "animateDrop", userInfo: nil, repeats: true)
    }
    
    func animateDrop() {
        drop2ImageView.animation = "shake"
        drop2ImageView.animate()
        
        drop3ImageView.animation = "shake"
        drop3ImageView.animate()

        drop4ImageView.animation = "shake"
        drop4ImageView.animate()
    }
    

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }

    
    
//    let baseLeft:CGPoint = CGPointMake(80, 195)
//    let baseRight:CGPoint = CGPointMake(240, 195)
//    let maxLeft:CGPoint = CGPointMake(40, 85)
//    let maxRight:CGPoint = CGPointMake(240, 85)
//    
//    
//    func updatePath() {
//        
//        if height < 120 {
//            height += 0.5
//        }
//        else {
//            maxOffset -= 0.1
//            if maxOffset < 0 {
//                maxOffset = 0
//                displayLink?.invalidate()
//                displayLink = nil
//                
//                niceImageView.transform = CGAffineTransformMakeScale(0, 0)
//                niceImageView.alpha = 0
//                niceImageView.hidden = false
//                UIView.animateWithDuration(1.0, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { [weak self] () -> Void in
//                    self?.niceImageView.transform = CGAffineTransformIdentity
//                    self?.niceImageView.alpha = 1
//                    }, completion: nil)
//                
//                SoundPlayer.play("trumpet.mp3")
//                
//                if let timer = timer {
//                    timer.invalidate()
//                }
//                timer = nil
//
//            }
//        }
//        
//        if goUp {
//            bendableOffset.vertical -= step
//            if bendableOffset.vertical < -maxOffset {
//                goUp = false
//                bendableOffset.vertical = -maxOffset
//            }
//        }
//        else {
//            bendableOffset.vertical += step
//            if bendableOffset.vertical > maxOffset {
//                goUp = true
//                bendableOffset.vertical = maxOffset
//            }
//        }
//        
//        let path = UIBezierPath()
//        path.moveToPoint(baseLeft)
//        path.addLineToPoint(CGPoint(x: baseLeft.x - (40/115.0) * height, y: baseLeft.y - height))
//        
//        let newX = (80 - (40/115.0) * height)
//        let newWidth = maxRight.x - newX
//        
//        path.addQuadCurveToPoint(CGPointMake(newX + newWidth * 0.5, baseLeft.y - height),
//            controlPoint:CGPointMake(newX + newWidth * 0.25, baseLeft.y - height + bendableOffset.vertical))
//        
//        path.addQuadCurveToPoint(CGPointMake(240, baseLeft.y - height),
//            controlPoint:CGPointMake(newX + newWidth * 0.75, baseLeft.y - height - bendableOffset.vertical))
//        
//        path.addLineToPoint(baseRight)
//        path.addLineToPoint(baseLeft)
//        
//        path.closePath()
//        
//        shapeLayer.path = path.CGPath
//    }
//    
//    func tick(displayLink: CADisplayLink) {
//        updatePath()
//        
//    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let t = touches.first
//        let location = t?.locationInView(cupImageView)
//        print("\(location!.x), \(location!.y)")
//        
//    }

}
