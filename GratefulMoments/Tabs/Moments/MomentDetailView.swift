import SwiftUI
import SwiftData

struct MomentDetailView: View {
    @Bindable var moment: Moment   // SwiftData binding to the model
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $moment.title)
            }
            Section(header: Text("Note")) {
                TextEditor(text: $moment.note)
                    .frame(minHeight: 120)
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
                // You could add a button here to pick a new image
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
                    // Changes are automatically tracked by SwiftData
                    // Just dismiss the view
                    dismiss()
                }
            }
        }
    }
}
#Preview {
    NavigationStack {
        MomentDetailView(moment: Moment.sample)
    }
}
