// 
//  CubicCurveControls.swift
//
//  Created by Den Jo on 2021/03/31.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct CubicCurveControls {
    let control1: CGPoint
    let control2: CGPoint
}

extension CubicCurveControls: Identifiable {
    
    var id: String {
        "\(control1)\(control2)"
    }
}
