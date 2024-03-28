import Foundation

class MockData: DataSourceProtocol {
    
    var sport: Sport
    
    init(for sport: Sport) {
        self.sport = sport
    }
    
    func fetch(completion: @escaping ([Section]?) -> Void) {
        let mockEvents = generateMockEvents()
        completion(mockEvents)
    }
    
    func generateMockEvents() -> [Section] {
        var sections: [Section] = []
            
        switch sport {
        case .football:
            let laliga = League(country: "Spain", name: "LaLiga", logo: "laliga")
            let bundesliga = League(country: "Germany", name: "Bundesliga", logo: "bundesliga")
            let manchesterUnited = FootballTeam(name: "Manchester United", logo: "manchesterUnited")
            let barcelona = FootballTeam(name: "Barcelona", logo: "barcelona")
            let bayern = FootballTeam(name: "Bayern München", logo: "bayern")
            let borrusia = FootballTeam(name: "Borrusia Dortmund", logo: "borussia")
            
            var spainEvents: [Event] = []
            var germanyEvents: [Event] = []
            
            for _ in 0..<10 {
                let matchSpain = Event(homeTeam: manchesterUnited, awayTeam: barcelona, homeScore: Int.random(in: 0...3), awayScore: Int.random(in: 0...3), status: [.finished, .inProgress, .notStarted].randomElement() ?? .notStarted, time: TimeInterval(Int.random(in: 1710000000...1720000000)))
                spainEvents.append(matchSpain)

                let matchGermany = Event(homeTeam: bayern, awayTeam: borrusia, homeScore: Int.random(in: 0...3), awayScore: Int.random(in: 0...3), status: [.finished, .inProgress, .notStarted].randomElement() ?? .notStarted, time: TimeInterval(Int.random(in: 1710000000...1720000000)))
                germanyEvents.append(matchGermany)
            }
            
            let bundesligaSection = Section(league: bundesliga, events: germanyEvents)
            let laLigaSection = Section(league: laliga, events: spainEvents)
                
            sections.append(contentsOf: [laLigaSection, bundesligaSection])
                
        case .basketball:
            let nba = League(country: "USA", name: "NBA", logo: "nba")
            let lakers = FootballTeam(name: "Los Angeles Lakers", logo: "lakers")
            let gsw = FootballTeam(name: "Golden State Warriors", logo: "gsw")
            
            var events: [Event] = []
            
            for _ in 0..<10 {
                let match = Event(homeTeam: lakers, awayTeam: gsw, homeScore: Int.random(in: 99...120), awayScore: Int.random(in: 99...120), status: [.finished,.inProgress,.notStarted].randomElement() ?? .notStarted , time: TimeInterval(Int.random(in: 1710000000...1720000000)))
                events.append(match)
            }
            let nbaSection = Section(league: nba, events: events)
            sections.append(contentsOf: [nbaSection, nbaSection])
            
        case .amFootball:
            let nfl = League(country: "USA", name: "NFL", logo: "nfl")
            let buccaneers = FootballTeam(name: "Tampa Bay Buccaneers", logo: "buccaneers")
            let patriots = FootballTeam(name: "New England Patriots", logo: "patriots")
            
            var events: [Event] = []
            
            for _ in 0..<10 {
                let match = Event(homeTeam: buccaneers, awayTeam: patriots, homeScore: Int.random(in: 0...20), awayScore: Int.random(in: 0...20), status: [.finished,.inProgress,.notStarted].randomElement() ?? .notStarted , time: TimeInterval(Int.random(in: 1710000000...1720000000)))
                events.append(match)
                
            }
            let nflSection = Section(league: nfl, events: events)
            sections.append(contentsOf: [nflSection, nflSection])
        }
            
        return sections
    }
}
