import SwiftUI
import SwiftData

struct MomentDetailView: View {
    @Bindable var moment: Moment
    @Environment(\.dismiss) private var dismiss
    // let moment: MomentDisplay   // unified type for local + backend

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter Title", text: $moment.title)
                    .font(.headline)
            }

            Section(header: Text("Note")) {
                TextEditor(text: $moment.note)
                    .font(.body)
                    .frame(minHeight: 120, alignment: .topLeading)
            }

            Section(header: Text("Image")) {
                if let image = moment.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    Text("No image attached")
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Timestamp")) {
                Text(moment.timeStamp, style: .date)
                Text(moment.timeStamp, style: .time)
            }
        }
        .navigationTitle("Edit Moment")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    moment.isSynced = false
                    moment.lastUpdated = Date()
                    Task {
                            do {
                                try await SyncManager.shared.sync(moment: moment)
                            } catch {
                                print("Sync failed:", error)
                            }
                        }

                    dismiss()
                }
            }
        }
    }
}

