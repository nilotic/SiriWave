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
    var data: Wave3
    
    var animatableData: Wave3.AnimatableData {
        get { data.animatableData }
        set { data.animatableData = newValue }
    }
    
    // MARK: Private
    var primaryLineWidth: CGFloat = 1.5
    var secondaryLineWidth: CGFloat = 0.5
    var numberOfWaves: Int = 6
    var waveColor = Color.white
    
    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        var path = Path()
       /*
        let mid = rect.width / 2
        
        let halfHeight = rect.height / 2.0
        let maxAmplitude = halfHeight - primaryLineWidth
       
        let progress = 1.0 - CGFloat(i) / CGFloat(numberOfWaves)
        let normedAmplitude = (1.5 * progress - 0.8) * amplitude
        let multiplier = min(1.0, (progress/3.0*2.0) + (1.0/3.0))
        
        for x in stride(from: 0, to: rect.width + density, by: density) {
            let scaling = -pow(1 / mid * (x - mid), 2) + 1
            let y = scaling * maxAmplitude * normedAmplitude * sin(2 * .pi * frequency * (x / rect.width)  + phase) + rect.height/2.0
            
            if x == 0 {
                path.move(to: CGPoint(x:x, y:y))
            
            } else {
                path.addLine(to: CGPoint(x:x, y:y))
            }
        }
         */
        
        return path
    }
}
