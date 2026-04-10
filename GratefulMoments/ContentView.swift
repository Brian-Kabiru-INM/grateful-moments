import SwiftUI
import SwiftData

struct MomentDisplay: Identifiable {
    let id = UUID()
    let title: String
    let note: String
    let timeStamp: Date
    let image: UIImage?
}

struct ContentView: View {
    @State private var isPresented = false
    @State private var selectedTab = 0
    @State private var navigateToDetail = false
    
    @StateObject private var viewModel = MomentViewModel()
    @Query var moments: [Moment]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedTab) {
                    
                    // Moments Tab with header + honeycomb
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            headerView
                                .padding(.horizontal)
                            
                            HoneycombGrid(items: moments) { moment in
                                NavigationLink(destination: MomentDetailView(moment: moment)) {
                                    MomentEpitrochoidCard(moment: moment)
                                }
                                .contextMenu {
                                    Button(role: .destructive) {
                                        if let context = moment.modelContext {
                                            context.delete(moment)
                                            try? context.save()
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .tag(0)
                    
                    // Achievements Tab
                    VStack {
                        AchievementsListWrapper(moments: moments)
                    }
                    .background(Color.white)
                    .tag(1)
                    
                    // Profile Tab
                    VStack {
                        Text("Profile View")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    .background(Color.white)
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                CustomTabBar(selectedTab: $selectedTab)
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
            .onAppear {
                viewModel.fetchMoments(context: context)
            }
        }
    }
    
    // Header view
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text("Grateful Moments")
                .font(.headline)
            Spacer()
            Text("\(moments.count) 🔥")
                .font(.headline)
                .foregroundColor(.orange)
            Image("Hero")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .frame(maxWidth: .infinity, alignment: .center)
            Text("Through My Lens")
                .font(.caption)
                .foregroundColor(.gray)
                .italic()
        }
    }
}

// MARK: - Epitrochoid Card with Embedded Text
struct MomentEpitrochoidCard: View {
    let moment: Moment
    
    var body: some View {
        ZStack {
            if let image = moment.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(EpitrochoidShape(lobes: 4, baseRadius: 80, lobeDepth: 0.08))
                    .overlay(
                        VStack {
                            Spacer()
                            Text(moment.title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                            Text(moment.note)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(2)
                                .shadow(radius: 2)
                            Spacer(minLength: 8)
                        }
                        .padding()
                    )
            } else {
                EpitrochoidShape(lobes: 4, baseRadius: 80, lobeDepth: 0.08)
                    .fill(Color.orange.opacity(0.25))
                    .frame(width: 160, height: 160)
                    .overlay(
                        VStack {
                            Spacer()
                            Text(moment.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(moment.note)
                                .font(.caption)
                                .foregroundColor(.white)
                                .lineLimit(2)
                            Spacer(minLength: 8)
                        }
                        .padding()
                    )
            }
        }
        .padding(12)
        
    }
}


// MARK: - Honeycomb Grid Layout
struct HoneycombGrid<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content
    
    private let columns = 2
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: columns), spacing: 16) {
            ForEach(items) { item in
                content(item)
            }
        }
    }
}

struct EpitrochoidShape: Shape {
    var lobes: Int
    var baseRadius: CGFloat
    var lobeDepth: Double = 0.2
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let steps = 360
        
        for step in 0...steps {
            let angle = Double(step) * (2 * Double.pi / Double(steps))
            let lobeCount = Double(lobes)
            
            let radialDistance = Double(baseRadius) * (1 + 0.2 * cos(lobeCount * angle))
            
            let epitrochoidXCoordinate = center.x + CGFloat(radialDistance * cos(angle))
            let epitrochoidYCoordinate = center.y + CGFloat(radialDistance * sin(angle))
            
            if step == 0 {
                path.move(to: CGPoint(x: epitrochoidXCoordinate, y: epitrochoidYCoordinate))
            } else {
                path.addLine(to: CGPoint(x: epitrochoidXCoordinate, y: epitrochoidYCoordinate))
            }
        }
        
        path.closeSubpath()
        return path
    }
}

// MARK: - Custom Tab Bar
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "sun.max.fill")
                    Text("Moments").font(.caption)
                }
                .foregroundColor(selectedTab == 0 ? .orange : .gray)
                .onTapGesture { selectedTab = 0 }
                
                Spacer()
                
                VStack {
                    Image(systemName: "rosette")
                    Text("Achievements").font(.caption)
                }
                .foregroundColor(selectedTab == 1 ? .orange : .gray)
                .onTapGesture { selectedTab = 1 }
                
                Spacer()
            }
            .padding()
            .background(.white)
            .clipShape(Capsule())
            .shadow(radius: 8)
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack {
                Image(systemName: "person.crop.circle")
                Text("Profile").font(.caption)
            }
            .foregroundColor(selectedTab == 2 ? .orange : .gray)
            .padding()
            .background(.white)
            .clipShape(Capsule())
            .shadow(radius: 8)
            .onTapGesture { selectedTab = 2 }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}
