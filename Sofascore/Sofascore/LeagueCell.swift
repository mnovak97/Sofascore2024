import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueCell: UICollectionReusableView {

    static let identifier = "League Cell"
    private let leagueView: LeagueView = LeagueView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(league: League) {
        leagueView.configure(league: league)
    }
}

//MARK: BaseViewProtocol
extension LeagueCell: BaseViewProtocol {
    
    func addViews() {
        addSubview(leagueView)
    }

    func setupConstraints() {
        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
