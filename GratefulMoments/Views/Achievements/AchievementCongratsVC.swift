//
//  AchievementCongratsVC.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 11/03/2026.
//

import UIKit
import SnapKit
import SwiftUI   // Needed for previews

class AchievementCongratsVC: UIViewController {
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Congrats!"
        view.backgroundColor = .systemBackground

        label.text = "🎉 You did it!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - SwiftUI Preview
#Preview {
    UINavigationController(rootViewController: AchievementCongratsVC())
}
