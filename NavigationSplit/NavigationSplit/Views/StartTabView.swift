import SwiftUI

struct StartTabView: View {
    @EnvironmentObject var store: DataStore
    var body: some View {
        TabView {
            EmployeeListview()
                .tabItem {
                    Label("Employees", systemImage: "person.2.fill")
                }
            CompaniesListView()
                .tabItem {
                    Label("Companies", systemImage: "briefcase")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartTabView()
            .environmentObject(DataStore())
    }
}
