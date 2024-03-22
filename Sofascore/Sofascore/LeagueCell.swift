import Foundation
import UIKit
import SofaAcademic
import SnapKit

class LeagueCell: UICollectionReusableView {

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
