// 
//  SiriWave.swift
//
//  Created by Den Jo on 2021/03/30.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct SiriWave: Identifiable {
    let id = UUID()
    var scale: CGFloat = 0
    var gradient = RadialGradient(gradient: Gradient(colors: []), center: .zero, startRadius: 0, endRadius: 0)
}
