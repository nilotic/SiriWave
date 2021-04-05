// 
//  Curve.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Curve {
    var power: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    var time: CGFloat
}

extension Curve {
    
    init(power: CGFloat) {
        self.power = power
        
        amplitude = CGFloat.random(in: 0.1...1.0)
        frequency = CGFloat.random(in: 0.6...0.9)
        time      = CGFloat.random(in: -1.0...4.0)
    }
}

extension Curve: Identifiable {
    
    var id: String {
        "\(power)\(amplitude)\(frequency)\(time)"
    }
}