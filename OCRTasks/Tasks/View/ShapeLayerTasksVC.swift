//
//  WorkWithShapeLayer.swift
//  OCRTasks
//
//  Created by Dmitriy on 01.02.2023.
//

import Foundation
import UIKit

extension TasksVC {
    
    func settingViewFirstShapeLayerTasks() {
        firstShapeLayerTasks.lineWidth = 12
        firstShapeLayerTasks.lineCap = .round
        firstShapeLayerTasks.fillColor = nil
        firstShapeLayerTasks.strokeEnd = 1
        let color = UIColor.systemGray4
        firstShapeLayerTasks.strokeColor = color.cgColor
    }
    
    func settingViewSecondShapeLayerTasks() {
        secondShapeLayerTasks.lineWidth = 8
        secondShapeLayerTasks.lineCap = .round
        secondShapeLayerTasks.fillColor = nil
        secondShapeLayerTasks.strokeEnd = 0
        let color = UIColor(displayP3Red: 0.435, green: 0.376, blue: 0.718, alpha: 100)
        secondShapeLayerTasks.strokeColor = color.cgColor
    }
    
    func settingShapeLayer(_ shapeLayer : CAShapeLayer) {
        shapeLayer.frame = viewTasksVC.bounds
        let center = viewTasksVC.center
        let radius = viewTasksVC.frame.height/2
        let pi = Double.pi
        let path = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: pi,
                                    endAngle: 3*pi,
                                    clockwise: true)
        shapeLayer.path = path.cgPath
    }
}
