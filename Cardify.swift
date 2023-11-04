//
//  Cardify.swift
//  memorise
//
//  Created by Spencer Mckay on 23/10/23.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRaidus)
        
        if isFaceUp {
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            content
        }
        else {
            shape.fill()
        }
        content
            .opacity(isFaceUp ? 1 : 0)
    }
    
    private struct DrawingConstants {
        static let cornerRaidus: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
