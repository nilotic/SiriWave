// 
//  Wave3.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave3 {
    var amplitude: CGFloat
    var frequency: CGFloat
}

extension Wave3: Animatable {
    
    typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>
    
    var animatableData: Wave3.AnimatableData {
        get { AnimatablePair(amplitude, frequency) }
        
        set {
            amplitude = newValue.first
            frequency = newValue.second
        }
    }
}
