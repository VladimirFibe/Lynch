import SwiftUI

struct CompaniesListView: View {
    @EnvironmentObject var store: DataStore
    @State private var companyId: Company.ID?
    @State private var employeeId: Employee.ID?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List(store.companies, selection: $companyId) { company in
                Text(company.name)
                    .font(.title)
            }
            .navigationTitle("Companies")
        } content: {
            if let companyId {
                if let  company = store.company(id: companyId) {
                    List(company.employees, selection: $employeeId) { employee in
                        Text(employee.fullName).font(.title)
                    }
                    .navigationTitle("Employees")
                }
            } else {
                VStack {
                    Image("company")
                        .resizable()
                        .scaledToFit()
                    Text("Select Company")
                        .font(.title)
                }
                .padding()
            }
        } detail: {
            EmployeeView(employeeId: employeeId)
        }
        .navigationSplitViewStyle(.balanced)
        .onChange(of: companyId) { _ in
            employeeId = nil
        }
        .onChange(of: employeeId) { _ in
            columnVisibility = employeeId == nil ? .all : .doubleColumn
        }
    }
}

struct CompaniesListView_Previews: PreviewProvider {
    static var previews: some View {
        CompaniesListView()
            .environmentObject(DataStore())
    }
}
