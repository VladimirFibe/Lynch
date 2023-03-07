import Foundation

struct Company: Identifiable {
    var id: String
    var name: String
    var employees: [Employee] = []
}
