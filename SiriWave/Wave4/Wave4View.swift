// 
//  Wave4View.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave4View: View {
    
    // MARK: - Value
    // MARK: Private
    private var frequency: CGFloat = 1.5
    private var idleAmplitude: CGFloat = 0.01
    private var phaseShift: CGFloat = -0.15
    private var density: CGFloat = 1
    private var primaryLineWidth: CGFloat = 1.5
    private var secondaryLineWidth: CGFloat = 0.5
    private var numberOfWaves: Int = 6
    private var waveColor = Color.white
    private var amplitude: CGFloat = 1

    @State private var phase: CGFloat = 0
    
    
    
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ForEach(0..<numberOfWaves) { i in
                    
                Path { path in
                    let mid = proxy.size.width / 2
                    
                    let halfHeight = proxy.size.height / 2.0
                    let maxAmplitude = halfHeight - primaryLineWidth
                    
                    let progress = 1.0 - CGFloat(i) / CGFloat(numberOfWaves)
                    let normedAmplitude = (1.5 * progress - 0.8) * amplitude
                    
                    for x in stride(from: 0, to: proxy.size.width + density, by: density) {
                        let scaling = -pow(1 / mid * (x - mid), 2) + 1
                        let y = scaling * maxAmplitude * normedAmplitude * sin(2 * .pi * frequency * (x / proxy.size.width)  + phase) + proxy.size.height/2.0
                        
                        if x == 0 {
                            path.move(to: CGPoint(x:x, y:y))
                            
                        } else {
                            path.addLine(to: CGPoint(x:x, y:y))
                        }
                    }
                    
            
                }
                .stroke(lineWidth: i == 0 ? primaryLineWidth : secondaryLineWidth)
                .stroke(Color.gray)
                .opacity(min(1.0, ((1.0 - Double(i) / Double(numberOfWaves))/3.0*2.0) + (1.0/3.0)))
            }
            .animation(.easeInOut)
            .drawingGroup()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                phase += phaseShift
            }
        }
    }
}

#if DEBUG
struct Wave4View_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = Wave4View()
        
        Group {
            view
                .previewDevice("iPhone8")
                .preferredColorScheme(.light)
            
            view
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
