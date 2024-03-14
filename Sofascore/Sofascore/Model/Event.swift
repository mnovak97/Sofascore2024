import Foundation

struct Event {
    
    var homeTeam: FootballTeam
    var awayTeam: FootballTeam
    var homeScore: Int
    var awayScore: Int
    var status: MatchStatus
    var time: TimeInterval
    
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: time)
        return dateFormatter.string(from: date)
    }
}
