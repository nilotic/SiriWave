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
    private let amplitude: CGFloat = 1
    private let frequency: CGFloat = 1
    
    
    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            Path { path in
                let length = scale / frequency
                let y = proxy.size.height / 2
                
                let center   = (scale / 2) / frequency
                let controlY = scale * amplitude
                
                let count = max(Int(proxy.size.width / length), 1)
                
                let xOffset = (proxy.size.width - length * CGFloat(count)) / 2
                path.move(to: CGPoint(x: xOffset, y: proxy.size.height / 2))
                
                for i in 0..<count {
                    let controlX = center + length * CGFloat(i) + xOffset
                    path.addCurve(to: CGPoint(x: length * CGFloat(i + 1) + xOffset, y: y), control1: CGPoint(x: controlX, y: y - controlY), control2: CGPoint(x: controlX, y: y + controlY))
                }
            }
            .stroke(Color.red)
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
