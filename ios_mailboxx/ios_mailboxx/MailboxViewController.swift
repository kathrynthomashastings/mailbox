//
//  MailboxViewController.swift
//  ios_mailboxx
//
//  Created by Kathryn Hastings on 10/11/16.
//  Copyright © 2016 Kathryn Hastings. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var rightIconImageView: UIImageView!
    @IBOutlet weak var leftIconImageView: UIImageView!

    @IBOutlet weak var panelBackButton: UIButton!
    @IBOutlet weak var laterPanelImageView: UIImageView!
    @IBOutlet weak var listPanelImageView: UIImageView!
    
    // Declare message variables
    var messageOriginalCenter: CGPoint!
    var messageOffset: CGFloat!
    var messageSwipeRight: CGPoint!
    var messageSwipeLeft: CGPoint!

    // Set background colour variables
    var greyColour = UIColor(red: 227/255.0, green: 225/255.0, blue: 227/255.0, alpha: 1.0)
    var yellowColour = UIColor(red: 251/255.0, green: 210/255.0, blue: 51/255.0, alpha: 1.0)
    var brownColour = UIColor(red: 216/255.0, green: 165/255.0, blue: 116/255.0, alpha: 1.0)
    var redColour = UIColor(red: 235/255.0, green: 83/255.0, blue: 51/255.0, alpha: 1.0)
    var greenColour = UIColor(red: 112/255.0, green: 217/255.0, blue: 98/255.0, alpha: 1.0)
    var blueColour = UIColor(red: 113/255.0, green: 197/255.0, blue: 225/255.0, alpha: 1.0)
    
    // Set icons
    let archiveIcon = UIImage(named: "archive_icon.png")
    let deleteIcon = UIImage(named: "delete_icon.png")
    let laterIcon = UIImage(named: "later_icon.png")
    let listIcon = UIImage(named: "list_icon.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the scrollView content size.
        scrollView.contentSize = CGSize(width: 375, height: 2620)
        
        // Set message arguments
        messageOffset = 0
        messageSwipeRight = CGPoint(x: messageImageView.center.x - messageOffset,y: messageImageView.center.y)
        messageSwipeLeft = CGPoint(x: messageImageView.center.x + messageOffset,y: messageImageView.center.y)
        
        // Hide right and left icon images
        rightIconImageView.alpha = 0
        leftIconImageView.alpha = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMessage(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        print (location)
        
        if sender.state == UIGestureRecognizerState.began {
            
            print("Gesture began")
            messageOriginalCenter = messageImageView.center
            
        } else if sender.state == UIGestureRecognizerState.changed {

            print("Gesture is changing")
            messageImageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            
            if translation.x < -260 {
                
                // Icon should change to the list icon.
                self.rightIconImageView.alpha = 01
                self.rightIconImageView.image = listIcon
                self.rightIconImageView.center.x = self.messageImageView.frame.origin.x + self.messageImageView.frame.size.width + 30
                
                // Background color should change to brown.
                self.messageView.backgroundColor = self.brownColour

            } else if translation.x < -60 && translation.x > -260 {
                
                // Later icon should start moving with the translation.
                self.rightIconImageView.alpha = 01
                self.rightIconImageView.image = laterIcon
                self.rightIconImageView.center.x = self.messageImageView.frame.origin.x + self.messageImageView.frame.size.width + 30
                
                // Background should change to yellow.
                self.messageView.backgroundColor = self.yellowColour
                
            } else if translation.x < 0 && translation.x > -60 {
                
                // Initially, the revealed background color should be grey.
                self.messageView.backgroundColor = self.greyColour
                
                // As the reschedule icon is revealed, it should start semi-transparent and become fully opaque.
                self.rightIconImageView.alpha = 00.3
                self.rightIconImageView.image = laterIcon
                
            } else if translation.x < 60 && translation.x > 0 {
                
                // Initially, the revealed background color should be grey.
                self.messageView.backgroundColor = self.greyColour
                
                // As the archive icon is revealed, it should start semi-transparent and become fully opaque.
                self.leftIconImageView.alpha = 00.3
                self.leftIconImageView.image = archiveIcon
                
            } else if translation.x < 260 && translation.x > 60{
                
                // Archive icon should start moving with the translation.
                self.leftIconImageView.alpha = 01
                self.leftIconImageView.image = archiveIcon
                self.leftIconImageView.center.x = self.messageImageView.frame.origin.x - 30

                // Background should change to green.
                self.messageView.backgroundColor = self.greenColour
                
                
            } else if translation.x > 260 {
                
                // Icon changes to the delete icon
                self.leftIconImageView.alpha = 01
                self.leftIconImageView.image = deleteIcon
                self.leftIconImageView.center.x = self.messageImageView.frame.origin.x - 30
                
                // Background color changes to red
                self.messageView.backgroundColor = self.redColour
                
            }

        } else if sender.state == UIGestureRecognizerState.ended {
            
            print("Gesture ended")
            
            if translation.x < -260 {
                
                UIView.animate(withDuration: 00.3, animations: {
                
                    // Release? Message should continue to reveal the brown background.
                    self.messageView.backgroundColor = self.brownColour
                    self.messageImageView.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                    self.rightIconImageView.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                    self.rightIconImageView.alpha = 00
                    
                }) { (Bool) in
                    UIView.animate(withDuration: 00.3, animations: {
                        
                        // Animation is complete, show the list options.
                        self.listPanelImageView.alpha = 01
                        self.panelBackButton.alpha = 01
                    }, completion: nil)
                }

            } else if translation.x < -60 && translation.x > -260 {
                
                UIView.animate(withDuration: 00.3, animations: {
                    
                    // Release? Message should continue to reveal the yellow background.
                    self.messageView.backgroundColor = self.yellowColour
                    self.messageImageView.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                    self.rightIconImageView.center = CGPoint(x: -375, y: self.messageOriginalCenter.y)
                    self.rightIconImageView.alpha = 00

                }) { (Bool) in
                    UIView.animate(withDuration: 00.3, animations: {
                        
                        // Animation is complete, show the reschedule options.
                        self.laterPanelImageView.alpha = 01
                        self.panelBackButton.alpha = 01
                        }, completion: nil)
                
                }

            } else if translation.x < 0 && translation.x > -60 {
                
                // Released? Message should return to its initial position.
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageImageView.center = self.messageSwipeRight
                    }, completion: nil)

                
            } else if translation.x < 60 && translation.x > 0 {
                
                // Released? Message should return to its initial position.
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.messageImageView.center = self.messageSwipeRight
                    }, completion: nil)
                
            } else if translation.x < 260 && translation.x > 60 {
                
                UIView.animate(withDuration: 00.3, animations: {
                    
                    // Released? Message should continue to reveal the green background.
                    self.messageView.backgroundColor = self.greenColour
                    self.messageImageView.center = CGPoint(x: self.messageImageView.center.x + 375, y: self.messageOriginalCenter.y)
                    self.leftIconImageView.center = CGPoint(x: self.messageImageView.center.x + 375, y: self.messageOriginalCenter.y)
                    self.leftIconImageView.alpha = 00
                    
                }) { (Bool) in
                    UIView.animate(withDuration: 00.9, animations: {
                        // Animation is complete, hide the message.
                        self.feedView.center.y = self.feedView.center.y - 100
                    }) { (Bool) in
                        UIView.animate(withDuration: 00.9, animations: {
                            // Animation is complete, hide the message.
                            self.messageImageView.center = self.messageOriginalCenter
                        }){ (Bool) in
                            UIView.animate(withDuration: 00.9, animations: {
                                self.feedView.center.y = self.feedView.center.y + 100
                            })
                        }
                    }
                }

            } else if translation.x > 260 {
                
                UIView.animate(withDuration: 00.3, animations: {
                    
                    // Released? Message should continue to reveal the red background.
                    self.messageView.backgroundColor = self.redColour
                    self.messageImageView.center = CGPoint(x: self.messageImageView.center.x + 375, y: self.messageOriginalCenter.y)
                    self.leftIconImageView.center = CGPoint(x: self.messageImageView.center.x + 375, y: self.messageOriginalCenter.y)
                    self.leftIconImageView.alpha = 00
                    
                }) { (Bool) in
                    UIView.animate(withDuration: 00.9, animations: {
                        // Animation is complete, hide the message.
                        self.feedView.center.y = self.feedView.center.y - 100
                    }) { (Bool) in
                        UIView.animate(withDuration: 00.9, animations: {
                            // Animation is complete, hide the message.
                            self.messageImageView.center = self.messageOriginalCenter
                        }){ (Bool) in
                            UIView.animate(withDuration: 00.9, animations: {
                                self.feedView.center.y = self.feedView.center.y + 100
                            })
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func panelBackButton(_ sender: AnyObject) {
    
        // User can tap to dismissing the reschedule or list options.
        self.laterPanelImageView.alpha = 00
        self.listPanelImageView.alpha = 00
        self.panelBackButton.alpha = 00
        
        // After the reschedule or list options are dismissed, you should see the message finish the hide animation.
        UIView.animate(withDuration: 00.3, animations: {
            self.feedView.center.y = self.feedView.center.y - 100
            }) { (Bool) in
                UIView.animate(withDuration: 00.9, animations: {
                    self.messageImageView.center = self.messageOriginalCenter
                }) { (Bool) in
                    UIView.animate(withDuration: 00.9, animations: {
                        self.feedView.center.y = self.feedView.center.y + 100
                    })
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
