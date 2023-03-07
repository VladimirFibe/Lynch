import SwiftUI

struct Intro2View: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("NavigationLinks")
        }
    }
}

struct Intro2View_Previews: PreviewProvider {
    static var previews: some View {
        Intro2View()
    }
}

struct Author: Identifiable {
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
