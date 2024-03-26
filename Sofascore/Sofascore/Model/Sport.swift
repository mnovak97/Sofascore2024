import Foundation

enum Sport {
    case football, basketball, amFootball
    
    var slug: String {
        switch self {
        case .football:
            return "football"
        case .basketball:
            return "basketball"
        case .amFootball:
            return "american-football"
        }
    }
}
