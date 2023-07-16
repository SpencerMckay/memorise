//
//  ContentView.swift
//  memorise
//
//  Created by Spencer Mckay on 16/07/23.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["👻", "💀", "🗡️", "🌌", "✨", "🏁"]
    @State var emojiCount = 6
    
    
    var body: some View {
        VStack {
            Text("Memorise")
                .font(.largeTitle)
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self ) {
                        emoji in CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape
                Text(content)
            } else {
                shape.fill(Color(hue: 1.0, saturation: 0.0, brightness: 0.328))
            }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
