//
//  MainViewController.swift
//  GymApp
//
//  Created by Amanda Milloy on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var viewController1: UIViewController?
    var viewController2: UIViewController?
    var defaults = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.objectForKey("Favorites") == nil{
            let favorites = [FitnessClass]()
            let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(favorites)
            defaults.setObject(encodedClass, forKey: "Favorites")
            defaults.synchronize()
            print(UIApplication.sharedApplication().scheduledLocalNotifications)
        }
        //sets the NSUserDefaults for the one card data if they haven't been already
        if defaults.objectForKey("OneCard") == nil {
            
            var datesAndTimes = [String:[Float]]()
            var mondayDates = [String]()
            var tuesdayDates = [String]()
            var wednesdayDates = [String]()
            var thursdayDates = [String]()
            var fridayDates = [String]()
            var saturdayDates = [String]()
            var sundayDates = [String]()
            
            //grabs the data from the text file
            let oneCardData = arrayFromContentsOfFileWithName("buckData")
            
            var splitList = [[String]]()
            var splitListNumber = [[String]]()
            
            //separates the dates and times in the data
            for index in 0...oneCardData!.count-1{
                splitList.append(oneCardData![index].componentsSeparatedByString(","))
            }
            
            for index in 0...splitList.count-1 {
                
                let date = splitList[index][0]
                let time = splitList[index][1]
                let index = date.startIndex.advancedBy(5)
                let ch = date[index]
                
                //only grabs data if it does not fall in the summer
                if ch != "6" && ch != "7" && ch != "8" {
                    
                    splitListNumber.removeAll()
                    splitListNumber.append(time.componentsSeparatedByString(":"))
                    
                    //converts the time into a float
                    let myNum = splitListNumber[0][0] + "." + splitListNumber[0][1] + splitListNumber[0][2]
                    let myFloat = (myNum as NSString).floatValue
                    var arr = datesAndTimes[date]
                    
                    //for each date, adds the times to the dictionary as an array of floats
                    if arr != nil {
                        arr!.append(myFloat)
                        datesAndTimes[date] = arr!
                    }
                    else {
                        let num = [myFloat]
                        datesAndTimes[date] = num
                    }
                    
                    //compiles arrays of all of the dates that fall on each day of the week
                    let day = getDayOfWeek(date)
                    switch day {
                    case 1: if !sundayDates.contains(date) {
                        sundayDates.append(date)
                        }
                    case 2: if !mondayDates.contains(date) {
                        mondayDates.append(date)
                        }
                    case 3: if !tuesdayDates.contains(date) {
                        tuesdayDates.append(date)
                        }
                    case 4: if !wednesdayDates.contains(date) {
                        wednesdayDates.append(date)
                        }
                    case 5: if !thursdayDates.contains(date) {
                        thursdayDates.append(date)
                        }
                    case 6: if !fridayDates.contains(date) {
                        fridayDates.append(date)
                        }
                    case 7: if !saturdayDates.contains(date) {
                        saturdayDates.append(date)
                        }
                    default: break
                    }
                    
                }
                
            }
            
            //adds these data structures to NSUserDefaults
            defaults.setObject(sundayDates, forKey: "SundayDates")
            defaults.setObject(mondayDates, forKey: "MondayDates")
            defaults.setObject(tuesdayDates, forKey: "TuesdayDates")
            defaults.setObject(wednesdayDates, forKey: "WednesdayDates")
            defaults.setObject(thursdayDates, forKey: "ThursdayDates")
            defaults.setObject(fridayDates, forKey: "FridayDates")
            defaults.setObject(saturdayDates, forKey: "SaturdayDates")
            defaults.setObject(datesAndTimes, forKey: "DatesAndTimes")
            defaults.setInteger(1, forKey: "OneCard")
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return 0
        }
    }
    
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            return content.componentsSeparatedByString("\r")
        } catch _ as NSError {
            return nil
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let fitnessfavs = destination as? FitnessFavorites{
            fitnessfavs.title = sender?.textLabel??.text
        }
    }

    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        
        switch item.tag {
            
        case 1:
            if viewController1 == nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController1 = storyboard.instantiateViewControllerWithIdentifier("FitnessFavorites") as! FitnessFavorites
            }
            self.view.insertSubview(viewController1!.view!, belowSubview: self.mainTabBar)
            break
            
            
        case 2:
            if viewController2 == nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController2 = storyboard.instantiateViewControllerWithIdentifier("ViewController2") 
            }
            self.view.insertSubview(viewController2!.view!, belowSubview: self.mainTabBar)
            break
            
        default:
            break
            
        }
        

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("turnOff:"), name: "actionOnePressed", object: nil)
        
        func turnOff(notification:NSNotification){
            for notification1 in UIApplication.sharedApplication().scheduledLocalNotifications! {
                let userInfoCurrent = notification1.userInfo as! [String:AnyObject]
                let uid = userInfoCurrent["uid"] as! String
                if uid == (notification.userInfo!["uid"] as! String) {
                    UIApplication.sharedApplication().cancelLocalNotification(notification1)
                    break
                }
            }
        }
    }

    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
