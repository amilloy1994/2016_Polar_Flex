//
//  GeneralInfoViewController.swift
//  BowdoinGymApp
//
//  Created by Will Conover on 5/18/16.
//  Copyright © 2016 Amanda Milloy. All rights reserved.
//

import UIKit
import MessageUI

class GeneralInfoViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBAction func sendMailWilley(sender: UIButton) {
        let mailComposeViewController = self.configuredMailComposeViewController("nwilley@bowdoin.edu")
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func sendMailBirgit(sender: UIButton) {
        let mailComposeViewController = self.configuredMailComposeViewController("healthservices@bowdoin.edu")
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    @IBAction func sendMailBernie(sender: UIButton) {
        let mailComposeViewController = self.configuredMailComposeViewController("bhershbe@bowdoin.edu")
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController(email: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([email])
        mailComposerVC.setSubject("Information")
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var hours: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday
        switch weekDay!{
        case 2, 3, 4, 5, 6:
            hours.text = "Today's Hours: 6:30am - 12:00am"
        case 7:
            hours.text = "Today's Hours: 9:00am - 12:00am"
        case 1:
            hours.text = "Today's Hours: 8:00am - 10:00pm"
        default:
            break
        }
    }
    
}
