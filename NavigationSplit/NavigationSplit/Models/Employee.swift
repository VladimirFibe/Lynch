import Foundation

struct Employee: Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var department: String
    var slogan: String
    var title: String
    var company: Company
    
    var fullName: String {
        firstName + " " + lastName
    }
}
