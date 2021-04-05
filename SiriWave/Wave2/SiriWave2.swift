// 
//  SiriWave2.swift
//
//  Created by Den Jo on 2021/03/30.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct SiriWave2: Identifiable {
    let id = UUID()
    var scale: CGFloat = 0
    var gradient = RadialGradient(gradient: Gradient(colors: []), center: .zero, startRadius: 0, endRadius: 0)
}

extension SiriWave2: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension SiriWave2: Equatable {
    
    static func ==(lhs: SiriWave2, rhs: SiriWave2) -> Bool {
        lhs.id == rhs.id
    }
}
