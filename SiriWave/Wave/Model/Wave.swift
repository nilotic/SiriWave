// 
//  Wave.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave {
    var power: CGFloat
    var curves: [Curve]
}

extension Wave {
    
    init(power: CGFloat) {
        self.power = power
        curves = (0..<4).map { _ in Curve() }
    }
}

extension Wave: Identifiable {
    
    var id: String {
        "\(power)\(curves.reduce("") { $0 + $1.id })"
    }
}

extension Wave: Animatable {
    
    typealias AnimatableData = AnimatablePair<
                                    AnimatablePair<
                                        AnimatablePair<AnimatablePair<CGFloat, CGFloat>, CGFloat>,
                                        AnimatablePair<AnimatablePair<CGFloat, CGFloat>, CGFloat>
                                        >,
                                    
                                    AnimatablePair<
                                        AnimatablePair<AnimatablePair<CGFloat, CGFloat>, CGFloat>,
                                        AnimatablePair<AnimatablePair<CGFloat, CGFloat>, AnimatablePair<CGFloat, CGFloat>
                                        >
                                    >
                                >
    
    var animatableData: AnimatableData {
        get {
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(AnimatablePair(curves[0].amplitude, curves[0].frequency), curves[0].time),
                    AnimatablePair(AnimatablePair(curves[1].amplitude, curves[1].frequency), curves[1].time)
                ),
                
                AnimatablePair(
                    AnimatablePair(AnimatablePair(curves[2].amplitude, curves[2].frequency), curves[2].time),
                    AnimatablePair(AnimatablePair(curves[3].amplitude, curves[3].frequency), AnimatablePair(curves[3].time, power))
                )
            )
        }
        
        set {
            let curve1 = newValue.first.first
            curves[0].amplitude = curve1.first.first
            curves[0].frequency = curve1.first.second
            curves[0].time      = curve1.second
            
            let curve2 = newValue.first.second
            curves[1].amplitude = curve2.first.first
            curves[1].frequency = curve2.first.second
            curves[1].time      = curve2.second
            
            let curve3 = newValue.second.first
            curves[2].amplitude = curve3.first.first
            curves[2].frequency = curve3.first.second
            curves[2].time      = curve3.second
            
            let curve4 = newValue.second.second
            curves[3].amplitude = curve4.first.first
            curves[3].frequency = curve4.first.second
            curves[3].time      = curve4.second.first
            
            power = curve4.second.second
        }
    }
}

