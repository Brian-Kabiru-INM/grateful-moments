import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    /// Shared sample container for previews
    static let sample = DataContainer(includeSampleMoments: true)
    let modelContainer: ModelContainer

    var context: ModelContext {
        modelContainer.mainContext
    }

    init(includeSampleMoments: Bool = false) {

        let schema = Schema([
            Moment.self
        ])

        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: includeSampleMoments
        )

        do {
            modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )

            if includeSampleMoments {
                loadSampleMoments()
            }

            try context.save()

        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    private func loadSampleMoments() {
        for moment in Moment.sampleData {
            context.insert(moment)
        }
    }
}

extension View {
    /// Injects in-memory sample data for SwiftUI previews
    func sampleDataContainer() -> some View {
        self
            .environment(DataContainer.sample)
            .modelContainer(DataContainer.sample.modelContainer)
    }
}
