//
//  GraphView.swift
//  GymApp
//
//  Created by Amanda Milloy on 5/4/16.
//  Copyright © 2016 Will Conover. All rights reserved.
//

import UIKit

protocol GetDataForGraph : class {
    func pointsOnGraph(sender: GraphView) -> [CGPoint]
}

@IBDesignable

class GraphView: UIView {
    
    @IBInspectable var lineWidth : CGFloat = 2 { didSet { setNeedsDisplay() }}
    @IBInspectable var lineColor: UIColor = UIColor.whiteColor() { didSet { setNeedsDisplay() }}
    @IBInspectable var startColor: UIColor = UIColor.redColor() { didSet { setNeedsDisplay() }}
    @IBInspectable var endColor: UIColor = UIColor.greenColor() { didSet { setNeedsDisplay() }}
    
    weak var dataSource: GetDataForGraph?
    
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath()
        
        //creates and draws a color gradient
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    CGGradientDrawingOptions(rawValue: 0))
        
        
        path.lineWidth = lineWidth
        lineColor.set()
    
        // draws lines between the points received from the protocol function
        if var dataPoints = dataSource?.pointsOnGraph(self) {
            if(dataPoints.count > 1){
                for index in 0...dataPoints.count-1 {
                    var point = dataPoints[index]
                    if index == 0 {
                        path.moveToPoint(point)
                    }
                    else {
                        path.addLineToPoint(point)
                    }
                    //creates a circle at each point
                    point.x -= 5.0/2
                    point.y -= 5.0/2
                    let circle = UIBezierPath(ovalInRect: CGRect(origin: point,
                            size: CGSize(width: 5.0, height: 5.0)))
                    circle.fill()
                }
                
            }
        }
        path.stroke()
        
        
        
    }
    
    
    
}
