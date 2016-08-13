//
//  TableViewController.swift
//  GymApp
//
//  Created by Will Conover on 5/3/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit
import Foundation

protocol dailyClass{
    
}

class ClassSchedule: UITableViewController {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            return content.componentsSeparatedByString("\n")
        } catch _ as NSError {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath)

        let dayOfWeek = days[indexPath.item]
        cell.textLabel?.text = dayOfWeek
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    private struct Storyboard {
        static let CellReuseIdentifier = "customcell"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        if let ctvc = destination as? ClassTableViewController{
            ctvc.title = sender?.textLabel??.text
        }
    }
    
    var decodedClasses = [FitnessClass]()
    var days = [String]()
    
    override func viewDidLoad() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("Classes") == nil{
            let classList = arrayFromContentsOfFileWithName("Data")
            
            var splitList = [[String]]()
            for index in 0...classList!.count-1{
                splitList.append(classList![index].componentsSeparatedByString(","))
            }
            var classes = [FitnessClass]()
            for index in 0...splitList.count-1{
                let newClass = FitnessClass(day: splitList[index][1], instructor: splitList[index][2], className: splitList[index][0], time: splitList[index][3], room: splitList[index][4], noteTime: splitList[index][5], notifications: false)
                classes.append(newClass)
            }
            let encodedClass = NSKeyedArchiver.archivedDataWithRootObject(classes)
            defaults.setObject(encodedClass, forKey: "Classes")
            defaults.synchronize()
        }
        let decoded  = defaults.objectForKey("Classes") as! NSData
        decodedClasses = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [FitnessClass]
        for i in 0...decodedClasses.count-1{
            if !days.contains(decodedClasses[i].day){
                days.append(decodedClasses[i].day)
            }
        }
    }
    
    
}
