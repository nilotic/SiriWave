// 
//  Wave4.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave4 {
    let index: UInt
    let count: UInt
    let primaryLineWidth: CGFloat
    let amplitude: CGFloat
    let frequency: CGFloat
    let density: CGFloat
    var phase: CGFloat
}

extension Wave4: Animatable {
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
}

extension Wave4: Identifiable {
    
    var id: UInt {
        index
    }
    
    var lineWidth: CGFloat {
        index == 0 ? primaryLineWidth : secondaryLineWidth
    }
    
    var secondaryLineWidth: CGFloat {
        primaryLineWidth / 3
    }
    
    var progress: CGFloat {
        1 - CGFloat(index) / CGFloat(count)
    }
    
    var normedAmplitude: CGFloat {
        (1.5 * progress - 0.8) * amplitude
    }
    
    var opacity: Double {
        return index == 0 ? 1 : min(1, ((1 - Double(index) / Double(count)) / 6) + 1 / 3)
    }
}
