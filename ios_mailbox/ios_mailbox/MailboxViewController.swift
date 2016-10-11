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
    @IBOutlet weak var archiveImage: UIImageView!
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var reschedulePanelImageView: UIImageView!
    @IBOutlet weak var reschedulePanelBackButton: UIButton!
    
    var messageOriginalCenter: CGPoint!
    var messageOffset: CGFloat!
    var messageRight: CGPoint!
    var messageLeft: CGPoint!
    var rescheduleImageOriginalCenter: CGPoint!
    
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
        
        // The didPan: method will be defined in Step 3 below.
        // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        // messageView.isUserInteractionEnabled = true
        // messageView.addGestureRecognizer(panGestureRecognizer)
        
        
        scrollView.contentSize = CGSize(width: 375, height: 2705)
        
        messageOffset = 0
        messageRight = CGPoint(x: messageImage.center.x - messageOffset,y: messageImage.center.y)
        messageLeft = CGPoint(x: messageImage.center.x + messageOffset,y: messageImage.center.y)
        
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
            rescheduleImageOriginalCenter = rescheduleImage.center
            
            // icon is semi-transparent
            archiveImage.alpha = 00.3
            rescheduleImage.alpha = 00.3
            
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
                        
                        // FRISBEE
                        self.rescheduleImage.center = CGPoint(x: self.messageImage.center.x + translation.x + 100, y: self.messageImage.center.y)
                    })
                    
                    if translation.x < -260 {
                        
                        // messageView background becomes brown
                        UIView.animate(withDuration:0.3, animations: {
                            self.messageView.backgroundColor = self.brownColour
                        })
                        
                        // icon changes to list icon

                        // released? maintains brown background and options appear once animation is complete
                        
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
                        UIView.animate(withDuration: 00.3, animations: {
                            
                            // options panel fades in
                            // self.reschedulePanelImageView.alpha = 1
                            
                            //execute segue programmatically
                            [self.performSegue(withIdentifier: "rescheduleSegue", sender: self)]
                            
                        }, completion: nil)
                    
                    }
                    
                    // messageView closes by decreasing height

                }
            }
        
        //            } else if reschedule > 260 {
        //
        //                icon changes to list icon
        //                background-color: brown
        //                released? maintains brown background
        //                and options appear once animation is complete
        //
        //            }
        
    }
    }
    
    @IBAction func reschedulePanelBackButton(_ sender: AnyObject) {
    
        // dismiss(animated: true, completion: nil)
        
    
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






