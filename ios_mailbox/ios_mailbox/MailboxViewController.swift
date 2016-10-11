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
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var archiveImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var reschedulePanelImageView: UIImageView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    var messageOriginalCenter: CGPoint!
    var feedOriginalCenter: CGPoint!
    var messageOffset: CGFloat!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    var rescheduleImageOriginalCenter: CGPoint!
    // var listImageOriginalCenter: CGPoint!
    
    var greyColour = UIColor(red: 227/255.0, green: 225/255.0, blue: 227/255.0, alpha: 1.0)
    var yellowColour = UIColor(red: 251/255.0, green: 210/255.0, blue: 51/255.0, alpha: 1.0)
    var brownColour = UIColor(red: 216/255.0, green: 165/255.0, blue: 116/255.0, alpha: 1.0)
    var redColour = UIColor(red: 235/255.0, green: 83/255.0, blue: 51/255.0, alpha: 1.0)
    var greenColour = UIColor(red: 112/255.0, green: 217/255.0, blue: 98/255.0, alpha: 1.0)
    var blueColour = UIColor(red: 113/255.0, green: 197/255.0, blue: 225/255.0, alpha: 1.0)

    //            messageView.backgroundColor = greyColour

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scrollView.contentSize = CGSize(width: 375, height: 2705)
        
        messageOffset = 0
        messageRight = CGPoint(x: messageImage.center.x - messageOffset,y: messageImage.center.y)
        messageLeft = CGPoint(x: messageImage.center.x + messageOffset,y: messageImage.center.y)
        
        self.archiveImage.alpha = 0
        self.listImage.alpha = 0
        self.rescheduleImage.alpha = 0
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMessage(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        print(location)
        
        
        if sender.state == .began {
            
            print("Gesture began")
            messageOriginalCenter = messageImage.center
            feedOriginalCenter = messageImage.center
            rescheduleImageOriginalCenter = rescheduleImage.center
            
            // icon is semi-transparent
            if translation.x < 0 {
                rescheduleImage.alpha = 00.3
            }
            
            // archiveImage.alpha = 00.3
            
        } else if sender.state == .changed {
            
            print("Gesture is changing")
            messageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if translation.x < 0 {
                
                UIView.animate(withDuration:0.3, animations: {
                    // icon becomes fully opaque
                    self.rescheduleImage.alpha = 01
                })
                
                if translation.x < -60 {
                    
                    UIView.animate(withDuration:0.6, animations: {
                        // messageView background becomes yellow
                        self.messageView.backgroundColor = self.yellowColour
                        
                        /// The left most x position of the message + the width + the amount you want it away from the right side
                        self.rescheduleImage.center.x = self.messageImage.frame.origin.x + self.messageImage.frame.size.width + 30

                    })
                    
                    if translation.x < -260 {
                        
                        /*
                        // messageView background becomes brown
                        UIView.animate(withDuration:0.3, animations: {
                            self.messageView.backgroundColor = self.brownColour
                        })

                        // icon changes to list icon
                        self.rescheduleImage.alpha = 0
                        self.listImage.alpha = 1
                        
                        /// The left most x position of the message + the width + the amount you want it away from the right side
                        self.listImage.center.x = self.messageImage.frame.origin.x + self.messageImage.frame.size.width + 30
                        */
                        
                    }
                    
                }

            }
            
        } else if sender.state == .ended {
            
            print("Gesture ended")
            
            if translation.x < 0 {

                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageImage.center = self.messageRight
                    }, completion: nil)

                if translation.x < -60 {
                
                    UIView.animate(withDuration: 00.6, animations: {
                        // messageView background remains yellow
                        self.messageView.backgroundColor = self.yellowColour

                        // messageImage and rescheduleImage pans left off screen
                        self.messageImage.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                        self.rescheduleImage.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                    
                    }) { (Bool) in
                        UIView.animate(withDuration: 00.6, animations: {
                            
                            // options panel fades in
                            [self.performSegue(withIdentifier: "rescheduleSegue", sender: self)]
                            
                        }, completion: nil)
                    
                    }
                    
                    if translation.x > -260 {
                        
                        /* 
                        UIView.animate(withDuration: 00.6, animations: {
                            // messageView background remains brown
                            self.messageView.backgroundColor = self.brownColour
                            
                            // messageImage and rescheduleImage pans left off screen
                            self.messageImage.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                            self.listImage.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                            
                        }) { (Bool) in
                            UIView.animate(withDuration: 00.6, animations: {
                                
                                // options panel fades in
                                [self.performSegue(withIdentifier: "listSegue", sender: self)]
                                
                                }, completion: nil)
                            
                        }
                        */
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func hideMessage() {
        
        // Hide the message
        print ("Message should hide")
        
        UIView.animate(withDuration: 00.6) {
            
            // BEGIN AGAIN
            
        }
        
    }
    

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        let rescheduleViewController = segue.destination as! RescheduleViewController
        
        // Pass the selected object to the new view controller.
        rescheduleViewController.mailboxViewController = self

    }
    
}






