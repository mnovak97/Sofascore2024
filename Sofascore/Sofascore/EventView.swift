import Foundation
import UIKit
import SofaAcademic
import SnapKit
import SwiftUI

class EventView: BaseView {
    
    private let matchStatusVerticalStack: UIStackView = .init()
    private let teamHorizontalStack: UIStackView = .init()
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
        addSubview(matchStatusVerticalStack)
        matchStatusVerticalStack.addArrangedSubview(timeLabel)
        matchStatusVerticalStack.addArrangedSubview(statusLabel)
        
        addSubview(teamHorizontalStack)
        
        teamHorizontalStack.addArrangedSubview(divider)
        
        teamHorizontalStack.addArrangedSubview(teamInfoVerticalStack)
        
        teamInfoVerticalStack.addArrangedSubview(homeTeamInfo)
        teamInfoVerticalStack.addArrangedSubview(awayTeamInfo)
        
        teamHorizontalStack.addArrangedSubview(scoreInfoVerticalStack)
        scoreInfoVerticalStack.addArrangedSubview(hometeamScore)
        scoreInfoVerticalStack.addArrangedSubview(awayTeamScore)
        
    }

    override func styleViews() {
        teamHorizontalStack.axis = .horizontal
        teamHorizontalStack.spacing = 16
        matchStatusVerticalStack.axis = .vertical
        matchStatusVerticalStack.spacing = 4
        timeLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        teamInfoVerticalStack.axis = .vertical
        teamInfoVerticalStack.spacing = 4
        scoreInfoVerticalStack.axis = .vertical
        scoreInfoVerticalStack.spacing = 4
        timeLabel.font = Fonts.micro
        timeLabel.textColor = Colors.onSurfaceLv2
        hometeamScore.teamScore.textAlignment = .right
        awayTeamScore.teamScore.textAlignment = .right
        statusLabel.font = Fonts.micro
        divider.backgroundColor = Colors.onSurfaceLv4
    }

    override func setupConstraints() {
        matchStatusVerticalStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(4)
            $0.width.equalTo(64)
        }
        teamHorizontalStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(matchStatusVerticalStack.snp.trailing)
        }
        divider.snp.makeConstraints {
            $0.width.equalTo(1)
        }
        scoreInfoVerticalStack.snp.makeConstraints {
            $0.width.equalTo(32)
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
            } else if event.homeScore == event.awayScore {
                homeTeamInfo.teamNameLabel.textColor = Colors.onSurfaceLv2
                hometeamScore.teamScore.textColor = Colors.onSurfaceLv2
                awayTeamInfo.teamNameLabel.textColor = Colors.onSurfaceLv2
                awayTeamScore.teamScore.textColor = Colors.onSurfaceLv2
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
