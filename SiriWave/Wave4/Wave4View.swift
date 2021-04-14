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
    @State private var phase: CGFloat = 0
    
    @ObservedObject private var data = Wave4Data()
    
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ForEach(data.waves) {
                Wave4Shape(data: $0)
                    .stroke(lineWidth: $0.lineWidth)
                    .stroke(Color.white)
                    .opacity($0.opacity)
            }
            .animation(.easeInOut)
            .drawingGroup()
        }
        .onAppear {
            data.update()
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
