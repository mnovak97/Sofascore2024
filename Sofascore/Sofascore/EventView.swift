import Foundation
import UIKit
import SofaAcademic
import SnapKit
import SwiftUI

class EventView: BaseView {
    
    let eventHorizontalStack: UIStackView = .init()
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
    let divider: UIView = .init()
    
    override func addViews() {
        addSubview(eventHorizontalStack)
        eventHorizontalStack.axis = .horizontal
        eventHorizontalStack.spacing = 16
        
        eventHorizontalStack.addArrangedSubview(matchStatusVerticalStack)
        matchStatusVerticalStack.axis = .vertical
        matchStatusVerticalStack.distribution = .fillEqually
        matchStatusVerticalStack.addArrangedSubview(timeLabel)
        matchStatusVerticalStack.addArrangedSubview(statusLabel)
        timeLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        
        eventHorizontalStack.addArrangedSubview(divider)
        
        eventHorizontalStack.addArrangedSubview(teamInfoVerticalStack)
        teamInfoVerticalStack.axis = .vertical
        teamInfoVerticalStack.distribution = .fillEqually
        
        teamInfoVerticalStack.addArrangedSubview(homeTeamHorizontalStack)
        homeTeamHorizontalStack.axis = .horizontal
        homeTeamHorizontalStack.spacing = 8
        homeTeamHorizontalStack.addArrangedSubview(homeTeamLogo)
        homeTeamHorizontalStack.addArrangedSubview(homeTeamName)
        homeTeamName.numberOfLines = 1
        
        teamInfoVerticalStack.addArrangedSubview(awayTeamHorizontalStack)
        awayTeamHorizontalStack.axis = .horizontal
        awayTeamHorizontalStack.spacing = 8
        awayTeamHorizontalStack.addArrangedSubview(awayTeamLogo)
        awayTeamHorizontalStack.addArrangedSubview(awayTeamName)
        awayTeamName.numberOfLines = 1
        
        eventHorizontalStack.addArrangedSubview(scoreInfoVerticalStack)
        scoreInfoVerticalStack.axis = .vertical
        scoreInfoVerticalStack.distribution = .fillEqually
        scoreInfoVerticalStack.addArrangedSubview(homeTeamScore)
        homeTeamScore.numberOfLines = 1
        scoreInfoVerticalStack.addArrangedSubview(awayTeamScore)
        awayTeamScore.numberOfLines = 1
        
    }

    override func styleViews() {
        timeLabel.font = ApplicationsFonts.micro
        timeLabel.textColor = ApplicationColors.secondaryColor
        statusLabel.font = ApplicationsFonts.micro
        homeTeamScore.font = ApplicationsFonts.body
        awayTeamScore.font = ApplicationsFonts.body
        homeTeamName.font = ApplicationsFonts.body
        awayTeamName.font = ApplicationsFonts.body
        divider.backgroundColor = ApplicationColors.dividerColor
    }

    override func setupConstraints() {
        eventHorizontalStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        matchStatusVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(eventHorizontalStack.snp.top)
            make.bottom.equalTo(eventHorizontalStack.snp.bottom)
            make.leading.equalTo(eventHorizontalStack.snp.leading)
            make.trailing.equalTo(divider.snp.leading)
            make.width.equalTo(64)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(matchStatusVerticalStack.snp.top)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(eventHorizontalStack.snp.top).inset(8)
            make.bottom.equalTo(eventHorizontalStack.snp.bottom).inset(8)
            make.width.equalTo(1)
        }
        
        teamInfoVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(eventHorizontalStack.snp.top)
            make.bottom.equalTo(eventHorizontalStack.snp.bottom)
            make.leading.equalTo(divider.snp.trailing).offset(16)
            make.trailing.equalTo(scoreInfoVerticalStack.snp.leading)
        }
        
        homeTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        awayTeamLogo.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
        homeTeamName.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        awayTeamName.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
        
        scoreInfoVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(eventHorizontalStack.snp.top)
            make.bottom.equalTo(eventHorizontalStack.snp.bottom)
            make.leading.equalTo(teamInfoVerticalStack.snp.trailing)
            make.trailing.equalTo(eventHorizontalStack.snp.trailing)
        }
        
        homeTeamScore.snp.makeConstraints { make in
            make.top.equalTo(scoreInfoVerticalStack.snp.top)
            make.width.equalTo(32)
        }
        
        awayTeamScore.snp.makeConstraints { make in
            make.top.equalTo(homeTeamScore.snp.bottom)
            make.width.equalTo(32)
        }
    }

    override func setupBinding() {
    }

    func configure(_ event: Event) {
        homeTeamName.text = event.homeTeam.name
        homeTeamLogo.image = UIImage(named: event.homeTeam.logo)
        homeTeamLogo.contentMode = .scaleAspectFit
        awayTeamName.text = event.awayTeam.name
        awayTeamLogo.image = UIImage(named: event.awayTeam.logo)
        awayTeamLogo.contentMode = .scaleAspectFit
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
        EventViewRepresentable().frame(height: 56)
    }
}
