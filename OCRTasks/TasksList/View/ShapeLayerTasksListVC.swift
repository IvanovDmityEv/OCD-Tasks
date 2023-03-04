//
//  ShapeLayerTasksListVC.swift
//  OCRTasks
//
//  Created by Dmitriy on 02.02.2023.
//

import Foundation
import UIKit


extension CellTasksList {
    
    func settingViewShapeLayer(_ shapeLayer: CAShapeLayer) {
        let frameView = viewTasksList.frame
        shapeLayer.frame = CGRect(x: 0, y: 0, width: frameView.width, height: frameView.height)
        
        let radius = frameView.height/2
                let pi = Double.pi
        
        let path = UIBezierPath(arcCenter: CGPoint(x: frameView.size.height/2, y: frameView.size.width/2),
                                radius: radius,
                                startAngle: pi,
                                endAngle: 3*pi, clockwise: true)
       
        shapeLayer.path = path.cgPath
        
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = nil
        if shapeLayer == firstShapeLayer {
            shapeLayer.lineWidth = 12
            shapeLayer.strokeEnd = 1
            shapeLayer.strokeColor = UIColor.systemGray4.cgColor
        } else if shapeLayer == secondShapeLayer {
            shapeLayer.lineWidth = 8
            shapeLayer.strokeEnd = 1

            let color = UIColor(displayP3Red: 0.435, green: 0.376, blue: 0.718, alpha: 100)
            shapeLayer.strokeColor = color.cgColor
        }
    }
}
