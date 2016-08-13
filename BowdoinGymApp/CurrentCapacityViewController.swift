//
//  CurrentCapacityViewController.swift
//  GymApp
//
//  Created by Amanda Milloy on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

class CurrentCapacityViewController: UIViewController {
    
    var brain = AverageBrain()

    @IBOutlet weak var currCapacity: UILabel!
    
    override func viewDidLoad() {
        numberOfPeopleInGym()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns the current hour
    func hour() -> Int {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        return hour
        
    }
    
    //returns the current minutes
    func minutes() -> Int {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let minutes = components.minute
        return minutes
        
    }
    
    //returns an estimate of the number of people in the gym at the current time
    //gets an array of times based on the current day of the week
    func numberOfPeopleInGym() -> Int {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Weekday, fromDate: date)
        let weekDay = components.weekday
        var averageTimes = [String:Int]()
        switch weekDay {
        case 1: averageTimes = brain.getAverageByDay("Sunday")
        case 2: averageTimes = brain.getAverageByDay("Monday")
        case 3: averageTimes = brain.getAverageByDay("Tuesday")
        case 4: averageTimes = brain.getAverageByDay("Wednesday")
        case 5: averageTimes = brain.getAverageByDay("Thursday")
        case 6: averageTimes = brain.getAverageByDay("Friday")
        case 7: averageTimes = brain.getAverageByDay("Saturday")
        default: break
        }
        
        var h = hour()
        let m = minutes()
        var min = ""
        var hr = ""
        var min2 = ""
        var hr2 = ""
        
        if h < 6 && h > 0 ||  h == 6 && m < 30 {
            currCapacity.text = "The gym is closed!"
        }
            
        //converts the current time into a time interval in the dictionary
        //calculates the next time interval in the dictionary
        //adds these two values together to get the estimate of people
        else {
            if m <= 15 {
                min = "00"
                min2 = "30"
                hr = "\(h)"
                hr2 = "\(h)"
            }
            else if m <= 45 {
                min = "30"
                min2 = "00"
                if h == 11 {
                    hr = "\(h)"
                    hr2 = "0"
                }
                else {
                    hr = "\(h)"
                    hr2 = "\(h+1)"
                }
            }
            else {
                min = "00"
                min2 = "30"
                if h == 11 {
                    min2 = "00"
                    hr = "0"
                    hr2 = "0"
                }
                else {
                    h = h+1
                    hr = "\(h)"
                    hr2 = "\(h)"
                }
            }
            
            let time1 = hr + ":" + min
            let time2 = hr2 + ":" + min2
            if averageTimes[time1] != nil {
                if averageTimes[time2] != nil {
                    let num = averageTimes[time1]! + averageTimes[time2]!
                    currCapacity.text = "There are " + "\(num)" + " people in the gym!"
                    return num
                }
            }
            else {
                var num = 0
                if averageTimes[time2] != nil {
                    num = num + averageTimes[time2]!
                    currCapacity.text = "There are " + "\(num)" + " people in the gym!"
                    return num
                }
                
            }
            
        }
        currCapacity.text = "There are 0 people in the gym!"
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


