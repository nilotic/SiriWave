// 
//  Wave4Shape.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave4Shape: Shape {
    
    // MARK: - Value
    // MARK: Public
    var data: Wave4
    
    var animatableData: Wave4.AnimatableData {
        get { data.animatableData }
        set { data.animatableData = newValue }
    }
    
    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        var path = Path()
       
        let middle = rect.width / 2
        let maxAmplitude = rect.height / 2 - data.lineWidth
       
        for x in stride(from: 0, to: rect.width + data.density, by: data.density) {
            let scaling = -pow(1 / middle * (x - middle), 2) + 1
            let y = scaling * maxAmplitude * data.normedAmplitude * sin(2 * .pi * data.frequency * (x / rect.width) + data.phase) + rect.height / 2
            
            switch x {
            case 0:     path.move(to: CGPoint(x: x, y: y))
            default:    path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
}
