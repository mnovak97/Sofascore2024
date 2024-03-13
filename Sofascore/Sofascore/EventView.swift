import Foundation
import UIKit
import SofaAcademic
import SnapKit
import SwiftUI

class EventView: BaseView {
    
    let matchStatusVerticalStack: UIStackView = .init()
    let homeTeamHorizontalStack: UIStackView = .init()
    let awayTeamHorizontalStack: UIStackView = .init()
    let teamInfoVerticalStack: UIStackView = .init()
    let scoreInfoVerticalStack: UIStackView = .init()
    let homeTeamName: UILabel = .init()
    let awayTeamName: UILabel = .init()
    let homeTeamScore: UILabel = .init()
    let awayTeamScore: UILabel = .init()
    let homeTeamLogo: UIImageView = .init()
    let awayTeamLogo: UIImageView = .init()
    let timeLabel: UILabel = .init()
    let statusLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(matchStatusVerticalStack)
        matchStatusVerticalStack.axis = .vertical
        matchStatusVerticalStack.spacing = 4
        matchStatusVerticalStack.addArrangedSubview(timeLabel)
        matchStatusVerticalStack.addArrangedSubview(statusLabel)
        timeLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        
        addSubview(teamInfoVerticalStack)
        teamInfoVerticalStack.axis = .vertical
        teamInfoVerticalStack.spacing = 4
        
        teamInfoVerticalStack.addArrangedSubview(homeTeamHorizontalStack)
        homeTeamHorizontalStack.axis = .horizontal
        homeTeamHorizontalStack.spacing = 8
        homeTeamHorizontalStack.addArrangedSubview(homeTeamLogo)
        homeTeamHorizontalStack.addArrangedSubview(homeTeamName)
        
        teamInfoVerticalStack.addArrangedSubview(awayTeamHorizontalStack)
        awayTeamHorizontalStack.axis = .horizontal
        awayTeamHorizontalStack.spacing = 8
        awayTeamHorizontalStack.addArrangedSubview(awayTeamLogo)
        awayTeamHorizontalStack.addArrangedSubview(awayTeamName)
        
        addSubview(scoreInfoVerticalStack)
        scoreInfoVerticalStack.axis = .vertical
        scoreInfoVerticalStack.spacing = 4
        scoreInfoVerticalStack.addArrangedSubview(homeTeamScore)
        scoreInfoVerticalStack.addArrangedSubview(awayTeamScore)
        
        
    }

    override func styleViews() {
        timeLabel.font = ApplicationsFonts.micro
        timeLabel.textColor = ApplicationColors.secondaryColor
        statusLabel.font = ApplicationsFonts.micro
        homeTeamScore.font = ApplicationsFonts.body
        awayTeamScore.font = ApplicationsFonts.body
        homeTeamName.font = ApplicationsFonts.body
        awayTeamName.font = ApplicationsFonts.body
        
    }

    override func setupConstraints() {
        matchStatusVerticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.trailing.equalTo(teamInfoVerticalStack.snp.leading).inset(20)
        }
        teamInfoVerticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(80)
            make.trailing.equalToSuperview()
        }
        
        scoreInfoVerticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
        }
        
        homeTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        awayTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
    }

    override func setupBinding() {
           // Set up bindings
    }

    func configure(_ event: Event) {
        homeTeamName.text = event.homeTeam.name
        homeTeamLogo.image = UIImage(named: event.homeTeam.logo)
        awayTeamName.text = event.awayTeam.name
        awayTeamLogo.image = UIImage(named: event.awayTeam.logo)
        awayTeamScore.text = "\(event.awayScore)"
        homeTeamScore.text = "\(event.homeScore)"
        timeLabel.text = event.formattedTime
        switch event.status {
        case .notStarted:
            statusLabel.text = ApplicationStrings.notStarted
            statusLabel.textColor = ApplicationColors.secondaryColor
            homeTeamScore.text = ApplicationStrings.empty
            awayTeamScore.text = ApplicationStrings.empty
        case .inProgress:
            statusLabel.text = ApplicationStrings.hardcodedTime
            statusLabel.textColor = ApplicationColors.liveColor
            homeTeamScore.text = "\(event.homeScore)"
            homeTeamScore.textColor = ApplicationColors.liveColor
            awayTeamScore.text = "\(event.awayScore)"
            awayTeamScore.textColor = ApplicationColors.liveColor
        case .finished:
            statusLabel.text = ApplicationStrings.fullTime
            statusLabel.textColor = ApplicationColors.secondaryColor
            if event.homeScore > event.awayScore {
                awayTeamName.textColor = ApplicationColors.secondaryColor
                awayTeamScore.textColor = ApplicationColors.secondaryColor
            } else if event.homeScore < event.awayScore {
                homeTeamName.textColor = ApplicationColors.secondaryColor
                homeTeamScore.textColor = ApplicationColors.secondaryColor
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
        EventViewRepresentable()
    }
}
