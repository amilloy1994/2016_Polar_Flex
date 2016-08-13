//
//  AverageBrain.swift
//  GymApp
//
//  Created by Amanda Milloy on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class AverageBrain{
    
    //retreives the times for a random date falling on the passed in day of the week
    func getAverageByDay(day: String) -> [String:Int] {
        
        var averageTimes = [String:Int]()
        let defaults = NSUserDefaults.standardUserDefaults()
        var times = [NSNumber]()
        
        if day == "Monday" {
            if let arr = defaults.objectForKey("MondayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else if day == "Tuesday" {
            if let arr = defaults.objectForKey("TuesdayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else if day == "Wednesday" {
            if let arr = defaults.objectForKey("WednesdayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else if day == "Thursday" {
            if let arr = defaults.objectForKey("ThursdayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else if day == "Friday" {
            if let arr = defaults.objectForKey("FridayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else if day == "Saturday" {
            if let arr = defaults.objectForKey("SaturdayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        else {
            if let arr = defaults.objectForKey("SundayDates") {
                let rand = Int(arc4random_uniform(UInt32(arr.count)))
                let date = String((arr as! [String])[rand])
                if let datesAndTimes = defaults.dictionaryForKey("DatesAndTimes") {
                    if let num = datesAndTimes[date] as? [NSNumber] {
                        times = num
                    }
                    
                }
                
            }
            
        }
        
        //places the time in a "time entering" category based on its value
        //adds up the number of people entering in each category and places it 
        //in the dictionary for that time interval
        //used for the points on the graph
        for time in times {
            
            if time.floatValue <= 6.45 {
                if averageTimes["6:30"] != nil {
                    averageTimes["6:30"]! += 1
                } else {
                    averageTimes["6:30"] = 1
                }
            }
            else if time.floatValue <= 7.15 {
                if averageTimes["7:00"] != nil {
                    averageTimes["7:00"]! += 1
                } else {
                    averageTimes["7:00"] = 1
                }
            }
            else if time.floatValue <= 7.45 {
                if averageTimes["7:30"] != nil {
                    averageTimes["7:30"]! += 1
                } else {
                    averageTimes["7:30"] = 1
                }
            }
            else if time.floatValue <= 8.15 {
                if averageTimes["8:00"] != nil {
                    averageTimes["8:00"]! += 1
                } else {
                    averageTimes["8:00"] = 1
                }
            }
            else if time.floatValue <= 8.45 {
                if averageTimes["8:30"] != nil {
                    averageTimes["8:30"]! += 1
                } else {
                    averageTimes["8:30"] = 1
                }
            }
            else if time.floatValue <= 9.15 {
                if averageTimes["9:00"] != nil {
                    averageTimes["9:00"]! += 1
                } else {
                    averageTimes["9:00"] = 1
                }
            }
            else if time.floatValue <= 9.45 {
                if averageTimes["9:30"] != nil {
                    averageTimes["9:30"]! += 1
                } else {
                    averageTimes["9:30"] = 1
                }
            }
            else if time.floatValue <= 10.15 {
                if averageTimes["10:00"] != nil {
                    averageTimes["10:00"]! += 1
                } else {
                    averageTimes["10:00"] = 1
                }
            }
            else if time.floatValue <= 10.45 {
                if averageTimes["10:30"] != nil {
                    averageTimes["10:30"]! += 1
                } else {
                    averageTimes["10:30"] = 1
                }
            }
            else if time.floatValue <= 11.15 {
                if averageTimes["11:00"] != nil {
                    averageTimes["11:00"]! += 1
                } else {
                    averageTimes["11:00"] = 1
                }
            }
            else if time.floatValue <= 11.45 {
                if averageTimes["11:30"] != nil {
                    averageTimes["11:30"]! += 1
                } else {
                    averageTimes["11:30"] = 1
                }
            }
            else if time.floatValue <= 12.15 {
                if averageTimes["12:00"] != nil {
                    averageTimes["12:00"]! += 1
                } else {
                    averageTimes["12:00"] = 1
                }
            }
            else if time.floatValue <= 12.45 {
                if averageTimes["12:30"] != nil {
                    averageTimes["12:30"]! += 1
                } else {
                    averageTimes["12:30"] = 1
                }
            }
            else if time.floatValue <= 13.15 {
                if averageTimes["13:00"] != nil {
                    averageTimes["13:00"]! += 1
                } else {
                    averageTimes["13:00"] = 1
                }
            }
            else if time.floatValue <= 13.45 {
                if averageTimes["13:30"] != nil {
                    averageTimes["13:30"]! += 1
                } else {
                    averageTimes["13:30"] = 1
                }
            }
            else if time.floatValue <= 14.15 {
                if averageTimes["14:00"] != nil {
                    averageTimes["14:00"]! += 1
                } else {
                    averageTimes["14:00"] = 1
                }
            }
            else if time.floatValue <= 14.45 {
                if averageTimes["14:30"] != nil {
                    averageTimes["14:30"]! += 1
                } else {
                    averageTimes["14:30"] = 1
                }
            }
            else if time.floatValue <= 15.15 {
                if averageTimes["15:00"] != nil {
                    averageTimes["15:00"]! += 1
                } else {
                    averageTimes["15:00"] = 1
                }
            }
            else if time.floatValue <= 15.45 {
                if averageTimes["15:30"] != nil {
                    averageTimes["15:30"]! += 1
                } else {
                    averageTimes["15:30"] = 1
                }
            }
            else if time.floatValue <= 16.15 {
                if averageTimes["16:00"] != nil {
                    averageTimes["16:00"]! += 1
                } else {
                    averageTimes["16:00"] = 1
                }
            }
            else if time.floatValue <= 16.45 {
                if averageTimes["16:30"] != nil {
                    averageTimes["16:30"]! += 1
                } else {
                    averageTimes["16:30"] = 1
                }
            }
            else if time.floatValue <= 17.15 {
                if averageTimes["17:00"] != nil {
                    averageTimes["17:00"]! += 1
                } else {
                    averageTimes["17:00"] = 1
                }
            }
            else if time.floatValue <= 17.45 {
                if averageTimes["17:30"] != nil {
                    averageTimes["17:30"]! += 1
                } else {
                    averageTimes["17:30"] = 1
                }
            }
            else if time.floatValue <= 18.15 {
                if averageTimes["18:00"] != nil {
                    averageTimes["18:00"]! += 1
                } else {
                    averageTimes["18:00"] = 1
                }
            }
            else if time.floatValue <= 18.45 {
                if averageTimes["18:30"] != nil {
                    averageTimes["18:30"]! += 1
                } else {
                    averageTimes["18:30"] = 1
                }
            }
            else if time.floatValue <= 19.15 {
                if averageTimes["19:00"] != nil {
                    averageTimes["19:00"]! += 1
                } else {
                    averageTimes["19:00"] = 1
                }
            }
            else if time.floatValue <= 19.45 {
                if averageTimes["19:30"] != nil {
                    averageTimes["19:30"]! += 1
                } else {
                    averageTimes["19:30"] = 1
                }
            }
            else if time.floatValue <= 20.15 {
                if averageTimes["20:00"] != nil {
                    averageTimes["20:00"]! += 1
                } else {
                    averageTimes["20:00"] = 1
                }
            }
            else if time.floatValue <= 20.45 {
                if averageTimes["20:30"] != nil {
                    averageTimes["20:30"]! += 1
                } else {
                    averageTimes["20:30"] = 1
                }
            }
            else if time.floatValue <= 21.15 {
                if averageTimes["21:00"] != nil {
                    averageTimes["21:00"]! += 1
                } else {
                    averageTimes["21:00"] = 1
                }
            }
            else if time.floatValue <= 21.45 {
                if averageTimes["21:30"] != nil {
                    averageTimes["21:30"]! += 1
                } else {
                    averageTimes["21:30"] = 1
                }
            }
            else if time.floatValue <= 22.15 {
                if averageTimes["22:00"] != nil {
                    averageTimes["22:00"]! += 1
                } else {
                    averageTimes["22:00"] = 1
                }
            }
            else if time.floatValue <= 22.45 {
                if averageTimes["22:30"] != nil {
                    averageTimes["22:30"]! += 1
                } else {
                    averageTimes["22:30"] = 1
                }
            }
            else if time.floatValue <= 23.15 {
                if averageTimes["23:00"] != nil {
                    averageTimes["23:00"]! += 1
                } else {
                    averageTimes["23:00"] = 1
                }
            }
            else if time.floatValue <= 23.45 {
                if averageTimes["23:30"] != nil {
                    averageTimes["23:30"]! += 1
                } else {
                    averageTimes["23:30"] = 1
                }
            }
            else if time.floatValue <= 24.0 {
                if averageTimes["0:00"] != nil {
                    averageTimes["0:00"]! += 1
                } else {
                    averageTimes["0:00"] = 1
                }
            }
            
        }
        
        return averageTimes
        
        
    }
    
    //takes in a time of day and returns an integer value
    //used for graphing
    func convertTimeToNumber(time: String) -> Int {
        var num = 0
        
        if time == "6:30" {
            num = 0
        }
        else if time == "7:00" {
            num = 1
        }
        else if time == "7:30" {
            num = 2
        }
        else if time == "8:00" {
            num = 3
        }
        else if time == "8:30" {
            num = 4
        }
        else if time == "9:00" {
            num = 5
        }
        else if time == "9:30" {
            num = 6
        }
        else if time == "10:00" {
            num = 7
        }
        else if time == "10:30" {
            num = 8
        }
        else if time == "11:00" {
            num = 9
        }
        else if time == "11:30" {
            num = 10
        }
        else if time == "12:00" {
            num = 11
        }
        else if time == "12:30" {
            num = 12
        }
        else if time == "13:00" {
            num = 13
        }
        else if time == "13:30" {
            num = 14
        }
        else if time == "14:00" {
            num = 15
        }
        else if time == "14:30" {
            num = 16
        }
        else if time == "15:00" {
            num = 17
        }
        else if time == "15:30" {
            num = 18
        }
        else if time == "16:00" {
            num = 19
        }
        else if time == "16:30" {
            num = 20
        }
        else if time == "17:00" {
            num = 21
        }
        else if time == "17:30" {
            num = 22
        }
        else if time == "18:00" {
            num = 23
        }
        else if time == "18:30" {
            num = 24
        }
        else if time == "19:00" {
            num = 25
        }
        else if time == "19:30" {
            num = 26
        }
        else if time == "20:00" {
            num = 27
        }
        else if time == "20:30" {
            num = 28
        }
        else if time == "21:00" {
            num = 29
        }
        else if time == "21:30" {
            num = 30
        }
        else if time == "22:00" {
            num = 31
        }
        else if time == "22:30" {
            num = 32
        }
        else if time == "23:00" {
            num = 33
        }
        else if time == "23:30" {
            num = 34
        }
        else if time == "0:00" {
            num = 35
        }
        return num
    }

    

    
}