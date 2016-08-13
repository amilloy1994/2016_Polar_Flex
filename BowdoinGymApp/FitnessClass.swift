//
//  FitnessClass.swift
//  GymApp
//
//  Created by Will Conover on 5/3/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import Foundation

public class FitnessClass: NSObject, NSCoding {
    
    public init(day: NSString, instructor: NSString, className: NSString, time: NSString, room: NSString, noteTime: NSString, notifications: Bool){
        self.instructor = instructor as String
        self.className = className as String
        self.day = day as String
        self.time = time as String
        self.room = room as String
        self.noteTime = noteTime as String
        self.notifications = notifications as Bool
    }
    public let instructor: String
    public let time: String
    public let room: String
    public let day: String
    public let className: String
    public let noteTime: String
    public var notifications: Bool
    
    required convenience public init(coder aDecoder: NSCoder) {
        let instructor = aDecoder.decodeObjectForKey("instructor") as! String
        let className = aDecoder.decodeObjectForKey("className") as! String
        let day = aDecoder.decodeObjectForKey("day") as! String
        let time = aDecoder.decodeObjectForKey("time") as! String
        let room = aDecoder.decodeObjectForKey("room") as! String
        let noteTime = aDecoder.decodeObjectForKey("noteTime") as! String
        let notifications = aDecoder.decodeObjectForKey("notifications") as! Bool
        self.init(day: day, instructor: instructor, className: className, time: time, room: room, noteTime: noteTime, notifications: notifications)
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(instructor, forKey: "instructor")
        aCoder.encodeObject(className, forKey: "className")
        aCoder.encodeObject(day, forKey: "day")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeObject(room, forKey: "room")
        aCoder.encodeObject(noteTime, forKey: "noteTime")
        aCoder.encodeObject(notifications, forKey: "notifications")
    }
}
