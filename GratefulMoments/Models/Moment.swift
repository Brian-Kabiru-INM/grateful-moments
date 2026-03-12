//
//  Moment.swift
//  GratefulMoments
//
//  Created by Brian Kabiru on 27/02/2026.
//

import Foundation
import SwiftData
import UIKit

@Model
class Moment {
    var title: String
    var note: String
    var imageData: Data?
    var timeStamp: Date
    init(title: String, note: String, imageData: Data? = nil, timeStamp: Date = .now) {
        self.title = title
        self.note = note
        self.imageData = imageData
        self.timeStamp = timeStamp
    }
    var image: UIImage? {
        imageData.flatMap {
            UIImage(data: $0)
        }
    }
}
enum AchievementBadge: String {
    case none = "No Badge"
    case bronze = "Bronze Badge"
    case silver = "Silver Badge"
    case gold = "Gold Badge"
}
extension Moment {
    static func badge(for moments: [Moment]) -> AchievementBadge {
        switch moments.count {
        case 0:
            return .none
        case 1:
            return .silver
        case 2...5:
            return .bronze
        default:
            return .gold
        }
    }
}

extension Moment {
    static let sample = sampleData[0]
    static let longTextSample = sampleData[1]
    static let imageSample = sampleData[4]

    static let sampleData = [
        Moment(
            title: "🍅🥳",
            note: "Picked my first homegrown tomato!"
        ),
        Moment(
            title: "Passed the test!",
            note: """
            The chem exam was tough, but I think I did well 🙌 I’m so glad I reached out. It really helped!
            """,
            imageData: UIImage(named: "Study")?.pngData()
        ),
        Moment(
            title: "Down time",
            note: "So grateful for a relaxing evening after a busy week.",
            imageData: UIImage(named: "Relax")?.pngData()
        ),
        Moment(
            title: "Family ❤️",
            note: ""
        ),
        Moment(
            title: "Rock on!",
            note: "Went to a great concert with Blair 🎶",
            imageData: UIImage(named: "Concert")?.pngData()
        )
    ]
}
