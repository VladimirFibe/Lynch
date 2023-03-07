import SwiftUI

struct Intro2View: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink(Author.sample[0].name, value: Author.sample[0].name)
                NavigationLink(Author.sample[1].name, value: Author.sample[0].numBooks)
                NavigationLink(Author.sample[2].name, value: Author.sample[0].color)
                NavigationLink(Author.sample[3].name, value: Author.sample[0])
                Button("Random") {
                    if let author = Author.sample.randomElement() {
                        path.append(author)
                    }
                }
            }
            .buttonStyle(.bordered)
            .navigationTitle("NavigationLinks")
            .navigationDestination(for: String.self) {
                Text($0).font(.largeTitle)
            }
            .navigationDestination(for: Int.self) {
                Text("\($0)").font(.largeTitle)
            }
            .navigationDestination(for: Color.self) {
                $0
            }
            .navigationDestination(for: Author.self) {
                Text("\($0.name), \($0.numBooks) books")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background($0.color)
            }
        }
    }
}

struct Intro2View_Previews: PreviewProvider {
    static var previews: some View {
        Intro2View()
    }
}

struct Author: Identifiable, Hashable {
    let name: String
    let numBooks: Int
    let color: Color
    var id: String {
        name
    }
    
    static var sample: [Author] {
        [
            .init(name: "Mark Twain", numBooks: 28, color: .orange),
            .init(name: "Robert Ludlum", numBooks: 27, color: .red),
            .init(name: "Robert Harris", numBooks: 18, color: .purple),
            .init(name: "Jane Austen", numBooks: 7, color: .cyan),
            .init(name: "Agatha Christie", numBooks: 66, color: .blue)
        ]
    }
}
