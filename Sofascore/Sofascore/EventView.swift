import Foundation
import UIKit
import SofaAcademic
import SnapKit
import SwiftUI

class EventView: BaseView {
    
    private let eventHorizontalStack: UIStackView = .init()
    private let matchStatusVerticalStack: UIStackView = .init()
    private let teamInfoVerticalStack: UIStackView = .init()
    private let homeTeamInfo: TeamInfoView = .init()
    private let awayTeamInfo: TeamInfoView = .init()
    private let scoreInfoVerticalStack: UIStackView = .init()
    private let hometeamScore: TeamScoreView = .init()
    private let awayTeamScore: TeamScoreView = .init()
    private let timeLabel: UILabel = .init()
    private let statusLabel: UILabel = .init()
    private let divider: UIView = .init()
    
    override func addViews() {
        addSubview(eventHorizontalStack)
        
        eventHorizontalStack.addArrangedSubview(matchStatusVerticalStack)
        matchStatusVerticalStack.addArrangedSubview(timeLabel)
        matchStatusVerticalStack.addArrangedSubview(statusLabel)
        
        eventHorizontalStack.addArrangedSubview(divider)
        
        eventHorizontalStack.addArrangedSubview(teamInfoVerticalStack)
        
        teamInfoVerticalStack.addArrangedSubview(homeTeamInfo)
        teamInfoVerticalStack.addArrangedSubview(awayTeamInfo)
        
        eventHorizontalStack.addArrangedSubview(scoreInfoVerticalStack)
        scoreInfoVerticalStack.addArrangedSubview(hometeamScore)
        scoreInfoVerticalStack.addArrangedSubview(awayTeamScore)
        
    }

    override func styleViews() {
        eventHorizontalStack.axis = .horizontal
        eventHorizontalStack.spacing = 16
        eventHorizontalStack.alignment = .center
        matchStatusVerticalStack.axis = .vertical
        matchStatusVerticalStack.spacing = 4
        matchStatusVerticalStack.distribution = .fillEqually
        timeLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        teamInfoVerticalStack.axis = .vertical
        teamInfoVerticalStack.spacing = 4
        teamInfoVerticalStack.distribution = .fillEqually
        scoreInfoVerticalStack.axis = .vertical
        scoreInfoVerticalStack.spacing = 4
        scoreInfoVerticalStack.distribution = .fillEqually
        timeLabel.font = Fonts.micro
        timeLabel.textColor = Colors.onSurfaceLv2
        statusLabel.font = Fonts.micro
        divider.backgroundColor = Colors.onSurfaceLv4
    }

    override func setupConstraints() {
        eventHorizontalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        matchStatusVerticalStack.snp.makeConstraints {
            $0.top.equalTo(eventHorizontalStack.snp.top).inset(10)
            $0.bottom.equalTo(eventHorizontalStack.snp.bottom).inset(10)
            $0.trailing.equalTo(divider.snp.leading)
            $0.width.equalTo(64)
        }
        divider.snp.makeConstraints {
            $0.top.equalTo(eventHorizontalStack.snp.top).inset(8)
            $0.bottom.equalTo(eventHorizontalStack.snp.bottom).inset(8)
            $0.width.equalTo(1)
        }
        teamInfoVerticalStack.snp.makeConstraints {
            $0.top.equalTo(eventHorizontalStack.snp.top).inset(10)
            $0.bottom.equalTo(eventHorizontalStack.snp.bottom).inset(10)
        }
        scoreInfoVerticalStack.snp.makeConstraints {
            $0.top.equalTo(eventHorizontalStack.snp.top).inset(10)
            $0.bottom.equalTo(eventHorizontalStack.snp.bottom).inset(10)
        }
    }

    override func setupBinding() {
    }

    func configure(_ event: Event) {
        homeTeamInfo.configure(teamName: event.homeTeam.name, teamLogo: event.homeTeam.logo)
        awayTeamInfo.configure(teamName: event.awayTeam.name, teamLogo: event.awayTeam.logo)
        timeLabel.text = event.formattedTime
        hometeamScore.configure(score: event.homeScore)
        awayTeamScore.configure(score: event.awayScore)
        
        switch event.status {
        case .notStarted:
            statusLabel.text = Strings.notStarted
            statusLabel.textColor = Colors.onSurfaceLv2
            hometeamScore.teamScore.text = Strings.empty
            awayTeamScore.teamScore.text = Strings.empty
        case .inProgress:
            statusLabel.text = Strings.hardcodedTime
            statusLabel.textColor = Colors.liveColor
            hometeamScore.teamScore.textColor = Colors.liveColor
            awayTeamScore.teamScore.textColor = Colors.liveColor
        case .finished:
            statusLabel.text = Strings.fullTime
            statusLabel.textColor = Colors.onSurfaceLv2
            if event.homeScore > event.awayScore {
                awayTeamInfo.teamNameLabel.textColor = Colors.onSurfaceLv2
                awayTeamScore.teamScore.textColor = Colors.onSurfaceLv2
            } else if event.homeScore < event.awayScore {
                homeTeamInfo.teamNameLabel.textColor = Colors.onSurfaceLv2
                hometeamScore.teamScore.textColor = Colors.onSurfaceLv2
            }
        }
    }
}


struct EventViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let teamOne = FootballTeam(name: "Manchester United", logo: "manchesterUnited")
        let teamTwo = FootballTeam(name: "Barcelona", logo: "barcelona")
        let eventView = EventView()
        eventView.configure(Event(homeTeam: teamOne, awayTeam: teamTwo, homeScore: 1, awayScore: 2, status: .finished, time: 1710331200))
        return eventView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

struct EventView_Previws: PreviewProvider {
    static var previews: some View {
        EventViewRepresentable().frame(height: 56)
    }
}
