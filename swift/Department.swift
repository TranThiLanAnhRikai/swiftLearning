import Foundation
enum Department: String {
    case bdg = "BDG"
    case g0 = "G0"
    case g3 = "G3"
    case g5 = "G5"
    // Add more cases if needed
    
    static var allCases: [Department] {
        return [.bdg, .g0, .g3, .g5]
    }
}

