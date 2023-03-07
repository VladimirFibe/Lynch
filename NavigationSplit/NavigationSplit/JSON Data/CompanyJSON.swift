import Foundation

struct CompanyJSON: Codable, Identifiable {
    var name: String
    let id: String
    var employees: [Employee]
    
    struct Employee: Codable, Identifiable, Hashable {
        let id: String
        var firstName: String
        var lastName: String
        var title: String
        var department: String
        var slogan: String
        
        var fullName: String {
            firstName + " " + lastName
        }
    }
}
