//
//  AchievementListWrapper.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 11/03/2026.
//

import SwiftUI
import UIKit

struct AchievementsListWrapper: UIViewControllerRepresentable {
    let moments: [Moment]

    func makeUIViewController(context: Context) -> UINavigationController {
        // Root UIKit VC
        let rootVC = AchievementsListVC(moments: moments)
        let navController = UINavigationController(rootViewController: rootVC)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        // For if moments change
    }
}
