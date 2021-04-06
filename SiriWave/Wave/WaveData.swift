// 
//  WaveData.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

final class WaveData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var waves = Array(repeating: Wave(power: 0), count: 3)
    let colors = [Color(#colorLiteral(red: 0.6784313725, green: 0.2235294118, blue: 0.2980392157, alpha: 1)), Color(#colorLiteral(red: 0.1882352941, green: 0.862745098, blue: 0.6078431373, alpha: 1)), Color(#colorLiteral(red: 0.09803921569, green: 0.4784313725, blue: 1, alpha: 1))]
  
    
    // MARK: - Function
    // MARK: Public
    func update(power: CGFloat) {
        waves = colors.map { _ in Wave(power: power) }
    }
}
