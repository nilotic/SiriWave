// 
//  SiriWaveShape.swift
//
//  Created by Den Jo on 2021/04/02.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct SiriWaveShape: Shape {
    
    // MARK: - Value
    // MARK: Public
    var scale: CGFloat = 0
    
    var animatableData: CGFloat {
        get { scale }
        set { scale = newValue }
    }
    
    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        let heightRatios: [CGFloat] = [1, 0.862, 0.396, 0, 0.396, 0.862, 1]
        
        let offset = scale < 1 ? (rect.size.height - (rect.size.height * scale)) / 2 : 0
        let size   = CGSize(width: rect.size.width, height: rect.size.height * scale)
        
        var points = [CGPoint]()
        
        // Top points
        for (i, ratio) in heightRatios.enumerated() {
            points.append(CGPoint(x: (CGFloat(i) / 6) * size.width, y: ratio * size.height / 2 + offset))
        }
        
        // Bottom points
        for point in points.reversed() {
            points.append(CGPoint(x: point.x, y: size.height - point.y + offset * 2))
        }
        
        
        // Paths
        let controls = calculateControls(data: points)
        var path = Path()
     
        for (i, point) in points.enumerated() {
            switch i {
            case 0:     path.move(to: point)
            default:    path.addCurve(to: point, control1: controls[i - 1].control1, control2: controls[i - 1].control2)
            }
        }
            
        path.closeSubpath()
        
        return path
    }
    
    // MARK: Private
    private func calculateControls(data: [CGPoint]) -> [CubicCurveControls] {
        var firstControls  = [CGPoint]()
        var secondControls = [CGPoint]()
        
        //Number of Segments
        let count = data.count - 1
        
        //P0, P1, P2, P3 are the points for each segment, where P0 & P3 are the knots and P1, P2 are the control points.
        switch count {
        case 1:
            let P0 = data[0]
            let P3 = data[1]
            
            // Calculate First Control Point (3P1 = 2P0 + P3)
            let P1x = (2 * P0.x + P3.x) / 3
            let P1y = (2 * P0.y + P3.y) / 3
            
            firstControls.append(CGPoint(x: P1x, y: P1y))
            
            // Calculate second Control Point (P2 = 2P1 - P0)
            let P2x = (2 * P1x - P0.x)
            let P2y = (2 * P1y - P0.y)
            
            secondControls.append(CGPoint(x: P2x, y: P2y))
            
        default:
            firstControls = Array(repeating: .zero, count: count)

            var rhsArray = [CGPoint]()
            
            //Array of Coefficients
            var a = [CGFloat]()
            var b = [CGFloat]()
            var c = [CGFloat]()
            
            for i in 0..<count {
                var rhsValueX: CGFloat = 0
                var rhsValueY: CGFloat = 0
                
                let P0 = data[i]
                let P3 = data[i + 1]
                
                switch i {
                case 0:
                    a.append(0)
                    b.append(2)
                    c.append(1)
                    
                    //rhs for first segment
                    rhsValueX = P0.x + 2 * P3.x
                    rhsValueY = P0.y + 2 * P3.y
                    
                case count - 1:
                    a.append(2)
                    b.append(7)
                    c.append(0)
                    
                    //rhs for last segment
                    rhsValueX = 8 * P0.x + P3.x;
                    rhsValueY = 8 * P0.y + P3.y;
                
                default:
                    a.append(1)
                    b.append(4)
                    c.append(1)
                    
                    rhsValueX = 4 * P0.x + 2 * P3.x
                    rhsValueY = 4 * P0.y + 2 * P3.y
                }
                
                rhsArray.append(CGPoint(x: rhsValueX, y: rhsValueY))
            }
            
            //Solve Ax=B. Use Tridiagonal matrix algorithm a.k.a Thomas Algorithm
            for i in 1..<count {
                let m = CGFloat(a[i] / b[i - 1])
                b[i] = b[i] - m * c[i - 1]
                
                rhsArray[i] = CGPoint(x: rhsArray[i].x - m * rhsArray[i - 1].x, y: rhsArray[i].y - m * rhsArray[i - 1].y)
            }
            
            //Get First Control Points
            firstControls[count - 1] = CGPoint(x: rhsArray[count - 1].x / b[count - 1], y: rhsArray[count - 1].y / b[count - 1])
            
            for i in (0 ..< count - 1).reversed() {
                let nextControlPoint = firstControls[i + 1]
                firstControls[i] = CGPoint(x: (rhsArray[i].x - c[i] * nextControlPoint.x) / b[i], y: (rhsArray[i].y - c[i] * nextControlPoint.y) / b[i])
            }
            
            //Compute second Control Points from first
            for i in 0..<count {
                switch i {
                case count - 1:
                    let P3 = data[i + 1]
                    let P1 = firstControls[i]
                    
                    secondControls.append(CGPoint(x: (P3.x + P1.x) / 2, y: (P3.y + P1.y) / 2))

                default:
                    let P3     = data[i + 1]
                    let nextP1 = firstControls[i + 1]
                    
                    secondControls.append(CGPoint(x: 2 * P3.x - nextP1.x, y: 2 * P3.y - nextP1.y))
                }
            }
        }
        
        var controls = [CubicCurveControls]()
        for i in 0..<count {
            controls.append(CubicCurveControls(control1: firstControls[i], control2: secondControls[i]))
        }
        
        return controls
    }
}
