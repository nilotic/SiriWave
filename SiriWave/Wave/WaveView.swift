//
//  WaveView.swift
//
//  Created by Den Jo on 2021/03/30.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct WaveView: View {
    
    // MARK: - Value
    // MARK: Public
    @StateObject var data = WaveData()
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Background
                Color(.clear)
                
                // Wave
                ForEach(Array(data.waves.enumerated()), id: \.element) { i, wave in
                    SiriWaveShape(scale: wave.scale)
                        .fill(wave.gradient)
                        .padding(.leading, CGFloat(i - data.waves.count / 2)  * 20)
                        .animation(Animation.easeInOut(duration: 0.78).delay(Double.random(in: 0...0.3)).repeatForever())
                }
                .frame(height: 350)
                .border(Color.gray)
                .drawingGroup()
            }
            .onAppear {
                data.update(size: proxy.size)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = WaveView()
        
        Group {
            view
                .previewDevice("iPhone 8")
                .preferredColorScheme(.light)
            
            view
                .previewDevice("iPhone 12")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
