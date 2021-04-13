// 
//  Wave3Shape.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

// https://stackoverflow.com/questions/42282793/drawing-the-waveform-effect-of-siri/66981902?noredirect=1#comment118401621_66981902

import SwiftUI

struct Wave3Shape: Shape {
    
    // MARK: - Value
    // MARK: Public
    var data: Wave3
    
    var animatableData: Wave3.AnimatableData {
        get { data.animatableData }
        set { data.animatableData = newValue }
    }
    
    // MARK: Private
    private let scale: CGFloat = 100
    
    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let length = scale / data.frequency
        let y = rect.height / 2
        
        let center   = (scale / 2) / data.frequency
        let controlY = scale * data.amplitude
        
        let count = max(Int(rect.width / length), 1)
        
        let xOffset = (rect.width - length * CGFloat(count)) / 2
        path.move(to: CGPoint(x: xOffset, y: rect.height / 2))
        
        for i in 0..<count {
            let controlX = center + length * CGFloat(i) + xOffset
            path.addCurve(to: CGPoint(x: length * CGFloat(i + 1) + xOffset, y: y), control1: CGPoint(x: controlX, y: y - controlY), control2: CGPoint(x: controlX, y: y + controlY))
        }
        
        return path
    }
}
