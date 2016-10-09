//
//  MailboxViewController.swift
//  ios_mailbox
//
//  Created by Kathryn Hastings on 10/8/16.
//  Copyright © 2016 Kathryn Hastings. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet var imageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImage: UIImageView!
    
    var messageOriginalCenter: CGPoint!
    var messageOffset: CGFloat!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scrollView.contentSize = CGSize(width: 375, height: 2705)
        
        messageOffset = 120
        messageRight = messageImage.center
        messageLeft = CGPoint(x: messageImage.center.x + messageOffset,y: messageImage.center.y)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMessage(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        
        if sender.state == .began {
            
            print("Gesture began")
            messageOriginalCenter = messageImage.center

            
        } else if sender.state == .changed {
            
            print("Gesture is changing")
            messageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)

            
        } else if sender.state == .ended {
            
            print("Gesture ended")
            
            if velocity.x > 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageImage.center = self.messageRight
                    }, completion: nil)
            } else {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageImage.center = self.messageRight
                    }, completion: nil)
            }
            
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
