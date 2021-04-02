// 
//  SiriWavePath.swift
//
//  Created by Den Jo on 2021/03/30.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

enum SiriWavePath {
    case move(to: CGPoint)
    case curve(to: CGPoint, control: CubicCurveControls)
    case close
}

extension SiriWavePath: Identifiable {
    
    var id: String {
        switch self {
        case .move(let point):                  return "\(point)"
        case .curve(let point, let control):    return "\(point)\(control.id)"
        case .close:                            return UUID().uuidString
        }
    }
}
