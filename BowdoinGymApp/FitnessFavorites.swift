//
//  FitnessFavorites.swift
//  BowdoinGymApp
//
//  Created by Will Conover on 5/11/16.
//  Copyright © 2016 Amanda Milloy. All rights reserved.
//

import UIKit

class FitnessFavorites: UITableViewController {

    var fitnessFavorites = [FitnessClass]()
    
    @IBAction func turnOffAll(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("Classes") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            decodedClasses[i].notifications=false
        }
        let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(decodedClasses)
        defaults.setObject(encodedClass, forKey: "Classes")
        defaults.synchronize()
        let favDecoded = defaults.objectForKey("Favorites") as! NSData
        let favDecodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(favDecoded) as! [FitnessClass]
        if favDecodedClasses.count>0{
            for i in 0...favDecodedClasses.count-1{
                        favDecodedClasses[i].notifications=false
            }
        }
        let favEncodedClass = NSKeyedArchiver.archivedDataWithRootObject(favDecodedClasses)
        defaults.setObject(favEncodedClass, forKey: "Favorites")
        defaults.synchronize()
        viewWillAppear(true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let cdvc = destination as? ClassDetailViewController{
            cdvc.title = sender?.textLabel??.text
            var day = (sender?.detailTextLabel??.text)!
            cdvc.dayOfWeek = (day.removeFirstChar)
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let defaults = NSUserDefaults()
        let deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") {action, index in
            if defaults.objectForKey("Favorites") != nil{
                let decoded  = defaults.objectForKey("Favorites") as! NSData
                self.fitnessFavorites = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
                for item in self.fitnessFavorites{
                    if item.className == self.fitnessFavorites[indexPath.item].className{
                        if item.day == self.fitnessFavorites[indexPath.item].day{
                            self.fitnessFavorites.removeAtIndex(indexPath.item)
                            break
                        }
                    }
                }
                let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(self.fitnessFavorites)
                defaults.setObject(encodedClass, forKey: "Favorites")
                defaults.synchronize()
                self.viewWillAppear(true)
            }
        }
        deleteAction.backgroundColor = UIColor.redColor()
        return [deleteAction]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults()
        let decoded = defaults.objectForKey("Favorites") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        if decodedClasses.count>0{
            for i in 0...decodedClasses.count-1{
                fitnessFavorites.append(decodedClasses[i])
            }
        }
    }
    
    override func viewWillAppear(animated: Bool){
        fitnessFavorites = [FitnessClass]()
        let defaults = NSUserDefaults()
        let decoded = defaults.objectForKey("Favorites") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        if decodedClasses.count>0{
            for i in 0...decodedClasses.count-1{
                fitnessFavorites.append(decodedClasses[i])
            }
        }
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fitnessFavorites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("classCell", forIndexPath: indexPath)
        cell.textLabel?.text = fitnessFavorites[indexPath.item].className
        cell.detailTextLabel?.text = fitnessFavorites[indexPath.item].day
        cell.backgroundColor = UIColor.clearColor()
        if fitnessFavorites[indexPath.item].notifications{
            cell.backgroundColor = UIColor.yellowColor()
        }
        return cell
    }
    
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
extension String {
    var removeFirstChar : String {
        mutating get {
            self.removeAtIndex(self.startIndex)
            return self
        }
    }
}
