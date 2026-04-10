import SwiftUI

// MARK: - Hexagon Shape

struct HexCard: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        path.move(to: CGPoint(x: width * 0.5, y: 0))
        path.addLine(to: CGPoint(x: width, y: height * 0.25))
        path.addLine(to: CGPoint(x: width, y: height * 0.75))
        path.addLine(to: CGPoint(x: width * 0.5, y: height))
        path.addLine(to: CGPoint(x: 0, y: height * 0.75))
        path.addLine(to: CGPoint(x: 0, y: height * 0.25))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Rounded Hexagon (Soft Corners Effect)

struct RoundedHexCard: View {
    var fill: Color
    
    var body: some View {
        HexCard()
            .fill(fill)
            .overlay(
                HexCard()
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
                    .blur(radius: 8)
            )
    }
}

// MARK: - Reusable Hex Card Container

struct HexCardContainer<Content: View>: View {
    let background: Color
    let content: Content
    
    init(
        background: Color = .orange,
        @ViewBuilder content: () -> Content
    ) {
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedHexCard(fill: background)
            content
                .padding(16)
        }
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 8)
    }
}

// MARK: - Text Hex Card

struct TextHexCard: View {
    var title: String
    var subtitle: String
    var date: String
    
    var body: some View {
        HexCardContainer(background: Color.orange) {
            VStack(spacing: 8) {
                
                Text(title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 4)
                
                Text(date)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .frame(width: 180)
    }
}

// MARK: - Image Hex Card

struct ImageHexCard: View {
    var imageName: String
    var title: String
    var subtitle: String
    var date: String
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
            
            LinearGradient(
                gradient: Gradient(colors: [
                    .clear,
                    .black.opacity(0.75)
                ]),
                startPoint: .center,
                endPoint: .bottom
            )
            
            VStack {
                Spacer()
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .bold()
                    
                    Text(subtitle)
                        .font(.subheadline)
                    
                    Text(date)
                        .font(.caption2)
                        .opacity(0.8)
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            }
        }
        .clipShape(HexCard())
        .aspectRatio(1, contentMode: .fit)
        .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
    }
}

// MARK: - Demo Screen (Matches Your Layout Direction)

struct HexcardView: View {
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Grateful Moments")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("75 🔥")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Spacer()
                
                // Text Card (Top Right Feel)
                HStack {
                    Spacer()
                    
                    TextHexCard(
                        title: "Catching my breath",
                        subtitle: "So grateful for a relaxing evening.",
                        date: "Oct 4"
                    )
                }
                .padding(.horizontal)
                
                // Image Card (Center)
                ImageHexCard(
                    imageName: "Concert", // replace with your asset
                    title: "Passed the test!",
                    subtitle: "⭐⭐⭐",
                    date: "Oct 5"
                )
                .frame(width: 240)
                
                Spacer()
                
                // Bottom Tabs (Simple Mock)
                HStack {
                    Spacer()
                    
                    VStack {
                        Image(systemName: "sun.max.fill")
                        Text("Moments")
                            .font(.caption)
                    }
                    .foregroundColor(.orange)
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "rosette")
                        Text("Achievements")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding()
                .background(.white)
                .clipShape(Capsule())
                .shadow(radius: 8)
                .padding(.horizontal, 40)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HexcardView()
}
