//
//  AspectVGrid.swift
//  memorise
//
//  Created by Spencer Mckay on 17/09/23.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item:Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = 50
            LazyVGrid(columns: [GridItem(.adaptive(minimum: width))]) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    init( items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView ) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
