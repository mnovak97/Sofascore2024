import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamInfoView: BaseView {
    
    private let teamInfoHorizontalStack: UIStackView = .init()
    private let teamLogoImage: UIImageView = .init()
    let teamNameLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(teamInfoHorizontalStack)
        teamInfoHorizontalStack.addArrangedSubview(teamLogoImage)
        teamInfoHorizontalStack.addArrangedSubview(teamNameLabel)
    }
    
    override func styleViews() {
        teamInfoHorizontalStack.axis = .horizontal
        teamInfoHorizontalStack.spacing = 8
        teamNameLabel.numberOfLines = 1
        teamNameLabel.font = Fonts.body
        teamLogoImage.contentMode = .scaleAspectFit
    }
    
    override func setupConstraints() {
        teamInfoHorizontalStack.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        teamLogoImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        teamNameLabel.snp.makeConstraints {
            $0.height.equalTo(16)
        }
    }
    
    func configure(teamName: String, teamLogo: String) {
        teamNameLabel.text = teamName
        teamLogoImage.image = UIImage(named: teamLogo)
    }
}
