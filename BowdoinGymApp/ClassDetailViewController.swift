//
//  ClassDetailViewController.swift
//  GymApp
//
//  Created by Will Conover on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func notificationSwitched(sender: UISwitch) {

        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("Classes") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            if decodedClasses[i].day == String(" "+dayOfWeek){
                if decodedClasses[i].className == title!{
                    decodedClasses[i].notifications=sender.on
                    
                    if sender.on == false{
                        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                            let userInfoCurrent = notification.userInfo as! [String:AnyObject]
                            let uid = userInfoCurrent["uid"] as! String
                            if uid == decodedClasses[i].day+decodedClasses[i].noteTime {
                                UIApplication.sharedApplication().cancelLocalNotification(notification)
                                break
                            }
                        }
                    }
                    
                    if sender.on == true{
                        var found = false
                        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
                            let userInfoCurrent = notification.userInfo as! [String:AnyObject]
                            let uid = userInfoCurrent["uid"] as! String
                            if uid == decodedClasses[i].day+decodedClasses[i].noteTime {
                                found = true
                            }
                        }
                        if !found{
                            setNotifications(decodedClasses[i].day, time: decodedClasses[i].noteTime, className: decodedClasses[i].className)
                        }
                    }
                    
                }
            }
        }
        let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(decodedClasses)
        defaults.setObject(encodedClass, forKey: "Classes")
        defaults.synchronize()
        let favDecoded = defaults.objectForKey("Favorites") as! NSData
        let favDecodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(favDecoded) as! [FitnessClass]
        if favDecodedClasses.count>0{
            for i in 0...favDecodedClasses.count-1{
                if favDecodedClasses[i].day == String(" "+dayOfWeek){
                    if favDecodedClasses[i].className == title!{
                        favDecodedClasses[i].notifications=sender.on
                    }
                }
            }
        }
        let favEncodedClass = NSKeyedArchiver.archivedDataWithRootObject(favDecodedClasses)
        defaults.setObject(favEncodedClass, forKey: "Favorites")
        defaults.synchronize()
    }
    
    @IBOutlet weak var noteSwitch: UISwitch!
    
    func testNotifications(){
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2016;
        dateComp.month = 05;
        dateComp.day = 17;
        dateComp.hour = 13;
        dateComp.minute = 21;
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        let calender:NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        let date:NSDate = calender.dateFromComponents(dateComp)!
        
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification"
        notification.fireDate = date
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    var dayOfWeek = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("Classes") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            if decodedClasses[i].day == String(" "+dayOfWeek){
                if decodedClasses[i].className == title!{
                    timeLabel.text?.appendContentsOf(decodedClasses[i].time)
                    locLabel.text?.appendContentsOf(decodedClasses[i].room)
                    noteSwitch.on=decodedClasses[i].notifications
                    instructorLabel.text?.appendContentsOf(decodedClasses[i].instructor)
                    if title! == "Vinyasa Flow Yoga" {
                        imageView.image = UIImage(named: "yoga.jpg")
                    }
                    else if title! == "Strength Circuit" {
                        imageView.image = UIImage(named: "images.png")
                    }
                    else if title! == "Zumba Toning" {
                        imageView.image = UIImage(named: "zumba.jpg")
                    }
                    else if title! == "Meditation" {
                        imageView.image = UIImage(named: "meditation.jpg")
                    }
                    else if title! == "Yin Yoga" {
                        imageView.image = UIImage(named: "yin.jpg")
                    }
                    else if title! == "Pedal Power" {
                        imageView.image = UIImage(named: "bike.jpg")
                    }
                    else if title! == "Tai Chi" {
                        imageView.image = UIImage(named: "tai.jpg")
                    }
                    else if title! == "Spin: Tabata & Core" {
                        imageView.image = UIImage(named: "abs.jpg")
                    }
                    else if title! == "Yoga Breaks" {
                        imageView.image = UIImage(named: "breaks.jpg")
                    }
                    else if title! == "BOSU Ball" {
                        imageView.image = UIImage(named: "bosu.jpg")
                    }
                    else if title! == "Pilates" {
                        imageView.image = UIImage(named: "pilates.jpg")
                    }
                    else if title! == "Qi Gong" {
                        imageView.image = UIImage(named: "qi.jpg")
                    }
                    
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func setNotifications(day: String, time: String, className: String){
        var found = false
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
            let userInfoCurrent = notification.userInfo as! [String:AnyObject]
            let uid = userInfoCurrent["uid"] as! String
            if uid == day+time {
                found = true
            }
        }
        if !found{
            let calendar: NSCalendar = NSCalendar.currentCalendar()
            let today = NSDate()
            let weekday = dayOfWeekToInt(day)
            let todayWeekday = calendar.component(.Weekday, fromDate: today)
            let components = NSDateComponents()
            components.weekday = weekday
            var dateString = ""
            if todayWeekday != weekday{
                let todayDayOfWeek = calendar.nextDateAfterDate(today, matchingComponents: components, options: NSCalendarOptions.MatchNextTime)
                dateString = (todayDayOfWeek?.description)!
            }
            else{
                dateString = today.description
            }
            dateString = dateString.substringToIndex(dateString.startIndex.advancedBy(10))
            let newDateFormatter = NSDateFormatter()
            newDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let newDate = newDateFormatter.dateFromString(dateString + " " + time)
            let notification = UILocalNotification()
            notification.timeZone = NSTimeZone.localTimeZone()
            notification.alertTitle = "Fitness Class is Starting:"
            notification.alertBody = className
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.fireDate = newDate
            notification.userInfo = ["uid": day+time]
            notification.repeatInterval = NSCalendarUnit.Weekday
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dayOfWeekToInt(day: String) -> Int{
        switch day{
        case " Monday":
            return 2
        case " Tuesday":
            return 3
        case " Wednesday":
            return 4
        case " Thursday":
            return 5
        case " Friday":
            return 6
        case " Saturday":
            return 7
        case " Sunday":
            return 1
        default:
            return 0
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

