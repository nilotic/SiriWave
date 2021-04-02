//
//  WaveData.swift
//  
//  Created by Den Jo on 2021/03/30.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

final class WaveData: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var waves: [SiriWave]
    
    
    // MARK: - Initializer
    init() {
        var waves = [SiriWave]()
        for _ in 0..<10 {
            waves.append(SiriWave())
        }
        
        self.waves = waves
    }
    
    
    // MARK: - Function
    // MARK Public
    func update(size: CGSize) {
        guard size != .zero else {
            log(.error, "Invalid screen size")
            return
        }
        
        var gradient: RadialGradient {
            let color = [Color(#colorLiteral(red: 0.9921568627, green: 0.2784313725, blue: 0.4039215686, alpha: 1)), Color(#colorLiteral(red: 0.368627451, green: 0.9882352941, blue: 0.662745098, alpha: 1)), Color(#colorLiteral(red: 0.1254901961, green: 0.5215686275, blue: 0.9882352941, alpha: 1))].randomElement() ?? .clear
            return RadialGradient(gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.1)]), center: .center, startRadius: 0, endRadius: size.width)
        }
        
        for i in 0..<waves.count {
            waves[i].gradient = gradient
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for i in 0..<self.waves.count {
                self.waves[i].scale = CGFloat.random(in: 0...1.0)
            }
        }
    }
}
