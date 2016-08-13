//
//  ClassTableViewController.swift
//  GymApp
//
//  Created by Will Conover on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {

    var dailyClasses = [FitnessClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("Classes") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            if decodedClasses[i].day == title{
                dailyClasses.append(decodedClasses[i])
            }
        }
    }

    @IBOutlet weak var titleBar: UINavigationItem!
    
    var favoriteClasses = [FitnessClass]()
    var defaults = NSUserDefaults()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let cdvc = destination as? ClassDetailViewController{            cdvc.title = sender?.textLabel??.text
            cdvc.dayOfWeek = titleBar.title!
        }
    }
    
    override func viewWillAppear(animated: Bool){
        dailyClasses = [FitnessClass]()
        let defaults = NSUserDefaults.standardUserDefaults()
        let decoded = defaults.objectForKey("Classes") as! NSData
        let decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            if decodedClasses[i].day == title{
                dailyClasses.append(decodedClasses[i])
            }
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dailyClasses.count
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let saveAction = UITableViewRowAction(style: .Normal, title: "Save") {action, index in
            if self.defaults.objectForKey("Favorites") != nil{
                let decoded  = self.defaults.objectForKey("Favorites") as! NSData
                self.favoriteClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
                let newClass = self.dailyClasses[indexPath.item]
                if self.favoriteClasses.count == 0{
                    self.favoriteClasses.append(newClass)
                }
                var isInList = false
                for item in self.favoriteClasses{
                    if item.className == newClass.className{
                        if item.day == newClass.day{
                            isInList = true
                        }
                    }
                }
                if !isInList{
                    self.favoriteClasses.append(newClass)
                }
                let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(self.favoriteClasses)
                self.defaults.setObject(encodedClass, forKey: "Favorites")
                self.defaults.synchronize()
            }
        }
        saveAction.backgroundColor = UIColor.lightGrayColor()
        return [saveAction]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("classCell", forIndexPath: indexPath)
        cell.textLabel?.text = dailyClasses[indexPath.item].className
        cell.detailTextLabel?.text = dailyClasses[indexPath.item].time
        cell.backgroundColor = UIColor.clearColor()
        if dailyClasses[indexPath.item].notifications{
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
