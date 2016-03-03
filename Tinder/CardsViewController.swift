//
//  CardsViewController.swift
//  Tinder
//
//  Created by kevin grennan on 3/2/16.
//  Copyright © 2016 kevin grennan. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

  
    @IBOutlet weak var ryanImage: UIImageView!
    
    var cardInitialCenter: CGPoint!
    var tinderTransition: TinderTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tinderTransition = TinderTransition()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        
        performSegueWithIdentifier("profileSegue", sender: self)
        
        
    
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destinationViewController = segue.destinationViewController as! ProfileViewController
        
        destinationViewController.image = self.ryanImage.image
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        destinationViewController.transitioningDelegate = tinderTransition
        
        
    }
    
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        var point = sender.locationInView(view)
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began{
            cardInitialCenter = ryanImage.center
            
            print(point)
        
        }else if sender.state == UIGestureRecognizerState.Changed{
            
            ryanImage.center.x = 160 + translation.x
            var imageRotationRight: CGFloat = convertValue(translation.x, r1Min: 0, r1Max: 160, r2Min: 0, r2Max: 20)
            var imageRotationLeft: CGFloat = convertValue(translation.x, r1Min: 0, r1Max: -160, r2Min: 0, r2Max: -20)
            
            
            if velocity.x > 0 && point.y < 220 {
                self.ryanImage.transform = CGAffineTransformMakeRotation(CGFloat(Double(imageRotationRight) * M_PI / 180))
            } else if velocity.x < 0 && point.y < 220{
                self.ryanImage.transform = CGAffineTransformMakeRotation(CGFloat(Double(imageRotationLeft) * M_PI / 180))
            } else if velocity.x > 0 && point.y > 220 {
                self.ryanImage.transform = CGAffineTransformMakeRotation(CGFloat(-Double(imageRotationRight) * M_PI / 180))
            } else if velocity.x < 0 && point.y > 220 {
                self.ryanImage.transform = CGAffineTransformMakeRotation(CGFloat(-Double(imageRotationLeft) * M_PI / 180))
            }
            
        }else if sender.state == UIGestureRecognizerState.Ended{
            
            if translation.x > 150 {
            
                UIView.animateWithDuration(0.3, animations: {
                    
                    self.ryanImage.center.x = 600
                    
                    }, completion: nil)
            
            }else if translation.x < -150 {
            
            
                UIView.animateWithDuration(0.3, animations: {
                    
                    self.ryanImage.center.x = -600
                    
                    }, completion: nil)
            
            
            }else {
            
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    self.ryanImage.center = self.cardInitialCenter
                    self.ryanImage.transform = CGAffineTransformIdentity
                    }, completion: nil)
            }
        }
    }
}
