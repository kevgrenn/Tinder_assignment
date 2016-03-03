//
//  TinderTransition.swift
//  Tinder
//
//  Created by kevin grennan on 3/2/16.
//  Copyright © 2016 kevin grennan. All rights reserved.
//

import UIKit

class TinderTransition: BaseTransition {
    
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let cardsViewController = fromViewController as! CardsViewController
        let profileViewController = toViewController as! ProfileViewController
        let temporaryImageView = UIImageView()
        
        temporaryImageView.frame = cardsViewController.ryanImage.frame
        temporaryImageView.image = cardsViewController.ryanImage.image
        temporaryImageView.clipsToBounds = cardsViewController.ryanImage.clipsToBounds
        temporaryImageView.contentMode = cardsViewController.ryanImage.contentMode
        
        containerView.addSubview(temporaryImageView)
        
        
        profileViewController.imageView.alpha = 0
        
        toViewController.view.alpha = 0
        UIView.animateWithDuration(0.5, animations: {
            toViewController.view.alpha = 1
            
            temporaryImageView.frame = profileViewController.imageView.frame
            
            }) { (finished: Bool) -> Void in
                
                profileViewController.imageView.alpha = 1
                temporaryImageView.removeFromSuperview()
                
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let cardsViewController = toViewController as! CardsViewController
        let profileViewController = fromViewController as! ProfileViewController
        let temporaryImageView = UIImageView()
        
        temporaryImageView.frame = profileViewController.imageView.frame
        temporaryImageView.image = profileViewController.imageView.image
        temporaryImageView.clipsToBounds = profileViewController.imageView.clipsToBounds
        temporaryImageView.contentMode = profileViewController.imageView.contentMode
        
        containerView.addSubview(temporaryImageView)

        cardsViewController.ryanImage.alpha = 0
        profileViewController.imageView.alpha = 0
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(0.5, animations: {
            fromViewController.view.alpha = 0
            
              temporaryImageView.frame = cardsViewController.ryanImage.frame
            
            }) { (finished: Bool) -> Void in
                
                cardsViewController.ryanImage.alpha = 1
                temporaryImageView.removeFromSuperview()
                profileViewController.imageView.alpha = 1
                
                self.finish()
        }

    }

}
