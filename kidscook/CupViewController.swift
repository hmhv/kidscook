//
//  CupViewController.swift
//  kidscook
//
//  Created by hmhv on 2015/11/17.
//  Copyright © 2015年 hmhv. All rights reserved.
//

import UIKit

class CupViewController: UIViewController {

    @IBOutlet weak var volvicImageView: DesignableImageView!
    @IBOutlet weak var cupImageView: UIImageView!
    @IBOutlet weak var niceImageView: UIImageView!
    @IBOutlet weak var waterTextImageView: UIImageView!
    @IBOutlet weak var waterImageView: UIImageView!
    
    
    private var bendableOffset = UIOffsetZero
    private var displayLink: CADisplayLink? = nil
    private var shapeLayer = CAShapeLayer()
    private var goUp: Bool = true
    private var height: CGFloat = 0
    private var step: CGFloat = 1.0
    private var maxOffset: CGFloat = 15
    var timer: NSTimer? = nil;

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "animateWater", userInfo: nil, repeats: true)
        
        UIView.animateWithDuration(4, animations: { () -> Void in
            self.waterImageView.frame.origin.y += 180
            }) { (_) -> Void in
                UIView.animateWithDuration(1) { () -> Void in
                    
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.waterImageView.frame.origin.x -= 30
                        self.waterImageView.frame.origin.y += 20
                        }) { (_) -> Void in
                            UIView.animateWithDuration(1) { () -> Void in
                                self.waterImageView.alpha = 0
                            }
                    }
                }
        }

        UIView.animateWithDuration(1) { () -> Void in
            self.waterTextImageView.frame.origin.y += 180
            self.waterTextImageView.frame.origin.x += 20
        }
    }
    
    func animateWater() {
        volvicImageView.delay = 1
        volvicImageView.duration = 1
        volvicImageView.animation = "swing"
        volvicImageView.animate()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
    }

    
    func startAnimation() {
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), { [weak self] in
            if let _self = self {
                _self.displayLink = CADisplayLink(target: _self, selector: "tick:")
                _self.displayLink!.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        niceImageView.hidden = true
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor(red: 17/255.0, green: 140/255.0, blue: 227/255.0, alpha: 1).CGColor
        
        cupImageView.layer.addSublayer(shapeLayer)
        
        startAnimation()
    }
    
    let baseLeft:CGPoint = CGPointMake(80, 195)
    let baseRight:CGPoint = CGPointMake(240, 195)
    let maxLeft:CGPoint = CGPointMake(40, 85)
    let maxRight:CGPoint = CGPointMake(240, 85)
    
    
    func updatePath() {
        
        if height < 120 {
            height += 0.5
        }
        else {
            maxOffset -= 0.1
            if maxOffset < 0 {
                maxOffset = 0
                displayLink?.invalidate()
                displayLink = nil
                
                niceImageView.transform = CGAffineTransformMakeScale(0, 0)
                niceImageView.alpha = 0
                niceImageView.hidden = false
                UIView.animateWithDuration(1.0, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: { [weak self] () -> Void in
                    self?.niceImageView.transform = CGAffineTransformIdentity
                    self?.niceImageView.alpha = 1
                    }, completion: nil)
                
                if let timer = timer {
                    timer.invalidate()
                }
                timer = nil

            }
        }
        
        if goUp {
            bendableOffset.vertical -= step
            if bendableOffset.vertical < -maxOffset {
                goUp = false
                bendableOffset.vertical = -maxOffset
            }
        }
        else {
            bendableOffset.vertical += step
            if bendableOffset.vertical > maxOffset {
                goUp = true
                bendableOffset.vertical = maxOffset
            }
        }
        
        let path = UIBezierPath()
        path.moveToPoint(baseLeft)
        path.addLineToPoint(CGPoint(x: baseLeft.x - (40/115.0) * height, y: baseLeft.y - height))
        
        let newX = (80 - (40/115.0) * height)
        let newWidth = maxRight.x - newX
        
        path.addQuadCurveToPoint(CGPointMake(newX + newWidth * 0.5, baseLeft.y - height),
            controlPoint:CGPointMake(newX + newWidth * 0.25, baseLeft.y - height + bendableOffset.vertical))
        
        path.addQuadCurveToPoint(CGPointMake(240, baseLeft.y - height),
            controlPoint:CGPointMake(newX + newWidth * 0.75, baseLeft.y - height - bendableOffset.vertical))
        
        path.addLineToPoint(baseRight)
        path.addLineToPoint(baseLeft)
        
        path.closePath()
        
        shapeLayer.path = path.CGPath
    }
    
    func tick(displayLink: CADisplayLink) {
        updatePath()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let t = touches.first
        let location = t?.locationInView(cupImageView)
        print("\(location!.x), \(location!.y)")
        
    }

}
