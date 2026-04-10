//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 27/02/2026.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Moment.self)
    }
}
