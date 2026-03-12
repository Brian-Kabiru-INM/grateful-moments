//
//  AchievementDetailVC.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 11/03/2026.
//

import UIKit
import SnapKit
import SwiftUI

class AchievementDetailVC: UIViewController {
    let moments: [Moment]
    private let badgeLabel = UILabel()
    private let congratsButton = UIButton(type: .system)

    init(moments: [Moment]) {
        self.moments = moments
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Badge Detail"
        view.backgroundColor = .systemBackground

        let badge = Moment.badge(for: moments)
        badgeLabel.text = "You earned: \(badge.rawValue)"
        badgeLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        congratsButton.setTitle("Celebrate!", for: .normal)
        congratsButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)

        [badgeLabel, congratsButton].forEach { view.addSubview($0) }

        badgeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        congratsButton.snp.makeConstraints { make in
            make.top.equalTo(badgeLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        congratsButton.addTarget(self, action: #selector(showCongrats), for: .touchUpInside)
    }

    @objc private func showCongrats() {
        let congratsVC = AchievementCongratsVC()
        navigationController?.pushViewController(congratsVC, animated: true)
    }
}

// MARK: - SwiftUI Preview
#Preview {
    UINavigationController(rootViewController: AchievementDetailVC(moments: Moment.sampleData))
}
