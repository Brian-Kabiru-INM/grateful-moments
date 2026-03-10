import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isPresented = false
    // Fetch all saved moments from SwiftData
    @Query var moments: [Moment]
    var body: some View {
        NavigationStack {
            TabView {
                // Moments Tab
                List {
                    Section(header: headerView) {
                        ForEach(moments) { moment in
                            NavigationLink(destination: MomentDetailView(moment: moment)) {
                                if let image = moment.image {
                                    HStack {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                        VStack(alignment: .leading) {
                                            Text(moment.title)
                                                .font(.headline)
                                            Text(moment.note)
                                                .font(.subheadline)
                                                .lineLimit(2)
                                        }
                                    }
                                } else {
                                    VStack(alignment: .leading) {
                                        Text(moment.title)
                                            .font(.headline)
                                        Text(moment.note)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteMoment)
                    }
                }
                .tabItem {
                    Label("Moments", systemImage: "sparkles")
                }
                // Achievements Tab
                VStack {
                    Text("Achievements Page Coming Soon")
                        .font(.title2)
                        .padding()
                }
                .tabItem {
                    Label("Achievements", systemImage: "star")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                MomentEntryView()
            }
        }
    }
    // Header view
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Grateful Moments")
                .font(.title)
                .bold()
            Spacer()
            Text("\(moments.count) 🔥")
                .font(.headline)
                .foregroundColor(.orange)
        }
    }
    // Delete handler
    private func deleteMoment(at offsets: IndexSet) {
        for index in offsets {
            let moment = moments[index]
            // Remove from context
            if let context = moment.modelContext {
                context.delete(moment)
                try? context.save()
            }
        }
    }
}

#Preview {
    ContentView()
        .sampleDataContainer()   // injects demo data for previews
}
