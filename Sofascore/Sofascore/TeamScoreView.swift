import Foundation
import UIKit
import SofaAcademic
import SnapKit

class TeamScoreView: BaseView {
    
    let teamScore: UILabel = .init()
    
    override func addViews() {
        addSubview(teamScore)
    }
    
    override func styleViews() {
        teamScore.font = Fonts.body
    }
    
    override func setupConstraints() {
        teamScore.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(score: Int) {
        teamScore.text = "\(score)"
    }
}
