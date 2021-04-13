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
        VStack {
            // Wave 1
            Text("Wave 1")
            
            WaveView(data: $power)
                .frame(height: 100)
                .border(Color.gray)
                
            
            Spacer()
                .frame(height: 150)
            
            
            // Wave 2
            Text("Wave 2")
                
            Wave2View()
                .frame(height: 100)
                .border(Color.gray)
            
            
            Spacer()
                .frame(height: 150)
            
            
            // Wave 3
            Text("Wave 3")
                
            Wave3View()
                .border(Color.gray)
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
