import SwiftUI

struct Intro1View: View {
    let items = ["🍎", "🍐", "🍋", "🍑", "🍌", "🍉", "🍇", "🍒", "🫐", "🍓"]
    var body: some View {
        NavigationStack {
            VStack {
                List(items, id: \.self) { fruit in
                    NavigationLink("I chose \(fruit)", value: fruit)
                }
                HStack {
                    NavigationLink("Tap to show preferred", value: items[7])
                    NavigationLink(value: "😀") {
                        Text("Other")
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
            }
            .padding()
            .navigationTitle("Fruit of the Day")
            .navigationDestination(for: String.self) {
                ChosenView(item: $0)
            }
        }
    }
}

struct ChosenView: View {
    let item: String
    var body: some View {
        Text("You chose \(item)")
            .font(.largeTitle)
    }
}
struct Intro1View_Previews: PreviewProvider {
    static var previews: some View {
        Intro1View()
    }
}
