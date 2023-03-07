import SwiftUI

struct EmployeeListview: View {
    @EnvironmentObject var store: DataStore
    @State private var employeeId: Employee.ID?
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.doubleColumn)) {
            List(store.filteredEmployees, selection: $employeeId) { employee in
                Text(employee.fullName)
            }
            .searchable(text: $store.employeeFilter)
            .navigationTitle("Employees")
        } detail: {
            EmployeeView(employeeId: employeeId)
        }
        .navigationSplitViewStyle(.balanced)

    }
}

struct EmployeeListview_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListview()
            .environmentObject(DataStore())
    }
}
