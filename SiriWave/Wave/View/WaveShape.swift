// 
//  WaveShape.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct WaveShape: Shape {
    
    // MARK: - Value
    // MARK: Public
    var wave: Wave
    
    var animatableData: Wave.AnimatableData {
        get { wave.animatableData }
        set { wave.animatableData = newValue }
    }
    
    
    // MARK: - Function
    // MARK: Public
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLines(calculate(frame: rect))
        
        return path
    }
    
    // MARK: Private
    private func calculate(frame: CGRect) -> [CGPoint] {
        let xPoints = Array(stride(from: -frame.midX, to: frame.midX, by: 1))
        var coordinates = [[CGFloat]](repeating: [0, 0], count: xPoints.count)
        
        for i in 0..<Int.random(in: 2...wave.curves.count) {
            let amplitude = wave.curves[i].amplitude * frame.midY * wave.power
            
            for (j, graphX) in xPoints.enumerated() {
                let x = graphX / (frame.midX / 9)
                let y = attenuate(x: x, amplitude: amplitude, frequency: wave.curves[i].frequency, time: wave.curves[i].time) + frame.midY
                
                coordinates[j] = [frame.midX + graphX, max(coordinates[j][1], y)]
            }
        }
        
        // Create inverse points
        coordinates += coordinates.map { [$0[0], frame.midY - ($0[1] - frame.midY)] }
                
        var points = [CGPoint]()
        for coordinate in coordinates {
            points.append(CGPoint(x: coordinate[0], y: coordinate[1]))
        }
        
        return points
    }

    private func attenuate(x: CGFloat, amplitude: CGFloat, frequency: CGFloat, time: CGFloat) -> CGFloat {
        let sine = amplitude * sin((frequency * x) - time)
        
        let K: CGFloat = 4 //  for the “attenuation equation”
        let globalAmplitude = pow(K / (K + pow((frequency * x) - (time - (CGFloat.pi / 2)), 2)), K)
        
        return abs(sine * globalAmplitude)
    }
}
