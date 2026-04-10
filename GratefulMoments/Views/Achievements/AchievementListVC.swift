//
//  AchievementsListVC.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 11/03/2026.
//

import UIKit
import SnapKit
import SwiftUI

class AchievementsListVC: UIViewController {
    let moments: [Moment]
    private let badgeLabel = UILabel()
    private let badgeImage = UIImageView()
    private let streakLabel = UILabel()
    private let detailButton = UIButton(type: .system)

    init(moments: [Moment]) {
        self.moments = moments
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Achievements"
        view.backgroundColor = .systemBackground

        // Configure UI
        let badge = Moment.badge(for: moments)
        badgeLabel.text = "Badge: \(badge.rawValue)"
        badgeLabel.font = .systemFont(ofSize: 20, weight: .bold)

        badgeImage.image = UIImage(named: "Badge")
        badgeImage.contentMode = .scaleAspectFit
        streakLabel.text = "Streak: \(moments.count) 🔥"
        streakLabel.font = .systemFont(ofSize: 16)

        detailButton.setTitle("View Details", for: .normal)
        detailButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)

        // Add to view
        [badgeLabel, badgeImage, streakLabel, detailButton].forEach { view.addSubview($0) }

        // Layout with SnapKit
        badgeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        badgeImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.centerX.equalToSuperview()
        }
        streakLabel.snp.makeConstraints { make in
            make.top.equalTo(badgeLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(streakLabel.snp.bottom).offset(400)
            make.centerX.equalToSuperview()
        }

        // Action
        detailButton.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
    }

    @objc private func showDetail() {
        let detailVC = AchievementDetailVC(moments: moments)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

#Preview {
    UINavigationController(rootViewController: AchievementsListVC(moments: Moment.sampleData))
}
