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

        dismiss(animated: true, completion: nil)
        // messageView closes by decreasing height
        
        self.messageView.hidden = true
        
    
    }
}