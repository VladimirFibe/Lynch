import SwiftUI

struct StartTab: View {
    @State var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            Intro1View()
                .tabItem { Label("Introduction", systemImage: "1.circle.fill") }.tag(1)
            Intro2View()
                .tabItem { Label("NavigationLinks", systemImage: "2.circle.fill") }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartTab()
    }
}
