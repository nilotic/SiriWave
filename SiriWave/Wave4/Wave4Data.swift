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
    
    private var waveTimer: Timer?  = nil
    private var powerTimer: Timer? = nil
    private var powers = [CGFloat]()
    
    
    // MARK: - Function
    // MARK: Public
    func update() {
        waveTimer?.invalidate()
        powerTimer?.invalidate()
        
        waveTimer = Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer in
            self.phase += self.phaseShift
            
            if let first = self.powers.first {
                self.amplitude = self.amplitude < first ? self.amplitude + 0.03 : self.amplitude - 0.03
                
                if abs(self.amplitude - first) < 0.1 {
                    self.powers.removeFirst()
                }
            }
            
            var waves = [Wave4]()
            for i in 0..<self.count {
                let wave = Wave4(index: i, count: self.count, primaryLineWidth: self.primaryLineWidth, amplitude: self.amplitude, frequency: self.frequency, density: self.density, phase: self.phase)
                waves.append(wave)
            }
            
            self.waves = waves
        }
        
        powerTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            self.powers.append(CGFloat.random(in: 0...1.5))
        }
    }
}
