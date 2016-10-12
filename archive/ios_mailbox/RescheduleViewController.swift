//
//  RescheduleViewController.swift
//  ios_mailbox
//
//  Created by Kathryn Hastings on 10/10/16.
//  Copyright © 2016 Kathryn Hastings. All rights reserved.
//

import UIKit

class RescheduleViewController: UIViewController {

    @IBOutlet weak var rescheduleBackButton: UIButton!
    
    // Declare a variable that will eventually link us back to the mailboxViewcontroller so we can call methods from the rescheduleViewController
    var mailboxViewController: MailboxViewController!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func rescheduleBack(_ sender: AnyObject) {

        // navigationController?.popViewController(animated: true)
        mailboxViewController.hideMessage()
        
        dismiss(animated: true, completion: nil)
        
        // messageView closes by decreasing height
        
        
    
    }
}
