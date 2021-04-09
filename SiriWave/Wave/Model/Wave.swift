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
        AnimatablePair<Curve.AnimatableData, Curve.AnimatableData>,
        AnimatablePair<Curve.AnimatableData, AnimatablePair<Curve.AnimatableData, CGFloat>>
    >
    
    var animatableData: AnimatableData {
        get {
            AnimatablePair(
                AnimatablePair(curves[0].animatableData, curves[1].animatableData),
                AnimatablePair(curves[2].animatableData, AnimatablePair(curves[3].animatableData, power))
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
            
            let curve4 = newValue.second.second.first
            curves[3].amplitude = curve4.first.first
            curves[3].frequency = curve4.first.second
            curves[3].time      = curve4.second
            
            power = newValue.second.second.second
        }
    }
}

