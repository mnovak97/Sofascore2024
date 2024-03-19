import Foundation

class MockData: DataSourceProtocol {
    
    func fetch(completion: @escaping ([Section]?) -> Void) {
        let mockEvents = MockData.generateMockEvents()
        completion(mockEvents)
    }
    
    static func generateMockEvents() -> [Section] {
        
        let laliga = League(country: "Spain", name: "LaLiga", logo: "laliga")
        let bundesliga = League(country: "Germany", name: "Bundesliga", logo: "bundesliga")
        let manchesterUnited = FootballTeam(name: "Manchester United", logo: "manchesterUnited")
        let barcelona = FootballTeam(name: "Barcelona", logo: "barcelona")
        let bayern = FootballTeam(name: "Bayern München", logo: "bayern")
        let borrusia = FootballTeam(name: "Borrusia Dortmund", logo: "borussia")
        
        var sections: [Section] = []
        var spainEvents: [Event] = []
        var germanyEvents: [Event] = []
        
        for _ in 0..<10 {
            let matchSpain = Event(homeTeam: manchesterUnited, awayTeam: barcelona, homeScore: Int.random(in: 0...3), awayScore: Int.random(in: 0...3), status: [.finished, .inProgress, .notStarted].randomElement() ?? .notStarted, time: TimeInterval(Int.random(in: 1710000000...1720000000)))
            spainEvents.append(matchSpain)
            
            let matchGermany = Event(homeTeam: bayern, awayTeam: borrusia, homeScore: Int.random(in: 0...3), awayScore: Int.random(in: 0...3), status: [.finished, .inProgress, .notStarted].randomElement() ?? .notStarted, time: TimeInterval(Int.random(in: 1710000000...1720000000)))
            germanyEvents.append(matchGermany)
            
        }
        
        let sectionOne = Section(league: laliga, events: spainEvents)
        let sectionTwo = Section(league: bundesliga, events: germanyEvents)
        sections.append(sectionOne)
        sections.append(sectionTwo)
        
        return sections
    }
}
