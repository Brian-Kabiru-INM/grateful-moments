//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 27/02/2026.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
