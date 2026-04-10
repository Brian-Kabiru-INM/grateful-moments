//
//  AchievementEntryView.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 11/03/2026.
//

import SwiftUI

struct AchievementEntryView: View {
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
            Image("Axe")
                .resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            Text("Hello Space!")
                .bold()
                .font(.title)
            Text("Page Under Construction")
                .font(.caption)
                .foregroundColor(.gray)
                .italic()
        })
}
               }
#Preview {
    AchievementEntryView()
}
