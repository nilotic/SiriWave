// 
//  HomeView.swift
//
//  Created by Den Jo on 2021/04/05.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Value
    // MARK: Private
    @State private var power: CGFloat = 0
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        VStack(spacing: 20) {
            // Wave 1
            Group {
                Text("Wave 1")
                
                WaveView(data: $power)
                    .frame(height: 100)
                    .border(Color.gray)
            }
                
            
            // Wave 2
            Group {
                Text("Wave 2")
                    
                Wave2View()
                    .frame(height: 100)
                    .border(Color.gray)
            }
            
            // Wave 3
            Group {
                Text("Wave 3")
                    
                Wave3View()
                    .frame(height: 100)
                    .border(Color.gray)
            }
            
            // Wave 4
            Group {
                Text("Wave 4")
                
                Wave4View()
                    .frame(height: 100)
                    .border(Color.gray)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                power = power == 0 ? CGFloat.random(in: 0...1.0) : 0
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = HomeView()
        
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
