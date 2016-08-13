//
//  GraphViewController.swift
//  GymApp
//
//  Created by Amanda Milloy on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GetDataForGraph {
    
    var brain = AverageBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.dataSource = self
        }
    }
    
    var dayOfWeek = String()

    @IBOutlet weak var graphKey: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pointsOnGraph(sender: GraphView) -> [CGPoint] {
        
        let arr = brain.getAverageByDay(dayOfWeek)
        var graphPoints = [CGPoint]()
        
        let xPadding: CGFloat = 30.0
        let yTopPadding: CGFloat = 100.0
        let yBottomPadding: CGFloat = 30.0
        
        //calculates the max number of people who have entered the gym during a certain time interval
        //used to demonstrate the scale on the graph
        let arrValues = arr.values
        let max = arrValues.maxElement()
        var maxTime = String()
        
        //each new person is represented by the yIncrement
        var yIncrement: CGFloat = 0
        if max != nil {
            yIncrement = (sender.bounds.size.height - (yTopPadding + yBottomPadding))/CGFloat(max!)
        }
        
        //the time intervals are spaced equally along the x axis
        let xIncrement = (sender.bounds.size.width - xPadding*2)/35.0
        
        var xValue: CGFloat = 0.0
        var yValue: CGFloat = 0.0

        let keyNum = 35
        
        //initializes the graph with 0 people for each time interval
        for index in 0...keyNum {
            xValue = xPadding + xIncrement*CGFloat(index)
            yValue = sender.bounds.size.height - yBottomPadding
            let point = CGPoint(x: xValue, y: yValue)
            graphPoints.append(point)
            
        }
        
        let arrKeys = arr.keys

        for time in arrKeys {
            let numTime = brain.convertTimeToNumber(time)
            
            //sets the time that has the max value in the dictionary as the maxTime
            if max != nil {
                if arr[time] == max! {
                    maxTime = time
                }
            }
            
            //sets x based on the integer value of the time
            xValue = xPadding + xIncrement*CGFloat(numTime)
            
            //grabs the value for the current time from the dictionary
            //sets y based on the padding and the yIncrement
            if arr[time] != nil {
                yValue = CGFloat(arr[time]!)
                yValue = sender.bounds.size.height - (yIncrement*yValue + yBottomPadding)
            }
            let point = CGPoint(x: xValue, y: yValue)
            graphPoints[numTime] = point
        }
        if max != nil {
            graphKey.text = "The max is " + "\(max!)" + " people entering at " + maxTime
            
        }
        
        return graphPoints
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
