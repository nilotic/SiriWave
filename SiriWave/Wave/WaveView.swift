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
                ForEach(data.waves) {
                    SiriWaveShape(scale: $0.scale)
                        .fill($0.gradient)
                        .animation(Animation.easeInOut(duration: 1).repeatForever())
                }
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
