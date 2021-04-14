// 
//  Wave4Data.swift
//
//  Created by Den Jo on 2021/04/14.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

final class Wave4Data: ObservableObject {
    
    // MARK: - Value
    // MARK: Public
    @Published var waves = [Wave4]()
    
    // MARK: Private
    private let frequency: CGFloat        = 1.5
    private var amplitude: CGFloat        = 0
    private let density: CGFloat          = 1
    private let primaryLineWidth: CGFloat = 1.5
    private let count: UInt               = 6
    
    private var phase: CGFloat      = 0
    private let phaseShift: CGFloat = -0.15
    private var timer: Timer? = nil
    
    
    // MARK: - Function
    // MARK: Public
    func update() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.018, repeats: true) { timer in
            self.phase += self.phaseShift
            self.amplitude = min(1, self.amplitude + 0.003)
        
            var waves = [Wave4]()
            for i in 0..<self.count {
                let wave = Wave4(index: i, count: self.count, primaryLineWidth: self.primaryLineWidth, amplitude: self.amplitude, frequency: self.frequency, density: self.density, phase: self.phase)
                waves.append(wave)
            }
            
            self.waves = waves
        }
    }
}
