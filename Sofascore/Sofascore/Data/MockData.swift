import Foundation

class MockData: DataSourceProtocol {
    
    func fetch(completion: @escaping ([Event]?) -> Void) {
        let mockEvents = MockData.generateMockEvents()
        completion(mockEvents)
    }
    
    static func generateMockEvents() -> [Event] {
        
        let homeTeam = FootballTeam(name: "Manchester United", logo: "manchesterUnited")
        let awayTeam = FootballTeam(name: "Barcelona", logo: "barcelona")
        
        let firstMatch = Event(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: 1, awayScore: 2, status: .finished, time: 1710331200)
        let secondMatch = Event(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: 0, awayScore: 1, status: .inProgress, time: 1710342000)
        let thirdMatch = Event(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: 0, awayScore: 0, status: .notStarted, time: 1710349200)
        let fourthdMatch = Event(homeTeam: homeTeam, awayTeam: awayTeam, homeScore: 0, awayScore: 0, status: .notStarted, time: 1710354600)
        
        var matches: [Event] = []
        matches.append(firstMatch)
        matches.append(secondMatch)
        matches.append(thirdMatch)
        matches.append(fourthdMatch)
        
        return matches
    }
}
