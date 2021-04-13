// 
//  Wave3View.swift
//
//  Created by Den Jo on 2021/04/13.
//  Copyright © nilotic. All rights reserved.
//

import SwiftUI

struct Wave3View: View {
    
    // MARK: - Value
    // MARK: Private
    private let scale: CGFloat = 100
    @State private var amplitude: CGFloat = 1
    @State private var frequency: CGFloat = 0
    
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        Wave3Shape(data: Wave3(amplitude: amplitude, frequency: frequency))
            .stroke(Color.red)
            .animation(.easeInOut)
            .drawingGroup()
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                    withAnimation {
                        amplitude = amplitude == -1 ? 1 : -1
                        frequency += 0.1
                    }
                }
            }
    }
}


#if DEBUG
struct Wave3View_Previews: PreviewProvider {
    
    static var previews: some View {
        let view = Wave3View()
        
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
