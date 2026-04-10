import Foundation

struct MomentDTO: Codable, Identifiable {
    let id: String
    let title: String
    let note: String
    let timeStamp: Date

    enum CodingKeys: String, CodingKey {
        case id, title, note, timeStamp
    }

    init(id: String, title: String, note: String, timeStamp: Date) {
        self.id = id
        self.title = title
        self.note = note
        self.timeStamp = timeStamp
    }

    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            id = try container.decode(String.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            note = try container.decode(String.self, forKey: .note)

            // Handle Double, Int, or String for timeStamp
            if let doubleValue = try? container.decode(Double.self, forKey: .timeStamp) {
                timeStamp = Date(timeIntervalSince1970: doubleValue)
            } else if let intValue = try? container.decode(Int.self, forKey: .timeStamp) {
                timeStamp = Date(timeIntervalSince1970: Double(intValue))
            } else if let stringValue = try? container.decode(String.self, forKey: .timeStamp),
                      let doubleValue = Double(stringValue) {
                timeStamp = Date(timeIntervalSince1970: doubleValue)
            } else {
                throw DecodingError.typeMismatch(
                    Double.self,
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "Expected Double, Int, or String for timeStamp"
                    )
                )
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(title, forKey: .title)
            try container.encode(note, forKey: .note)
            try container.encode(timeStamp.timeIntervalSince1970, forKey: .timeStamp)
        }

        func toMoment() -> Moment {
            Moment(
                title: title,
                note: note,
                timeStamp: timeStamp
            )
        }
}

// MARK: - Convert SwiftData → DTO
extension MomentDTO {
    init(from moment: Moment) {
        self.id = moment.backendID ?? UUID().uuidString
        self.title = moment.title
        self.note = moment.note
        self.timeStamp = moment.timeStamp
    }
}

// MARK: - Update SwiftData model from DTO
extension Moment {
    func update(from dto: MomentDTO) {
        self.backendID = dto.id
        self.title = dto.title
        self.note = dto.note
        self.timeStamp = dto.timeStamp
        self.isSynced = true
    }
}
