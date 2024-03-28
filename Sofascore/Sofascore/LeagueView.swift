import Foundation
import SwiftUI
import SofaAcademic
import SnapKit

class LeagueView: BaseView {
    
    private let leagueLogo: UIImageView = .init()
    private let leagueCountry: UILabel = .init()
    private let arrowImage: UIImageView = .init()
    private let leagueName: UILabel = .init()
    
    override func addViews() {
        addSubview(leagueLogo)
        addSubview(leagueCountry)
        addSubview(arrowImage)
        addSubview(leagueName)
    }
    
    override func styleViews() {
        leagueCountry.font = Fonts.headline3
        leagueName.font = Fonts.headline3
        leagueName.textColor = Colors.onSurfaceLv2
        leagueLogo.contentMode = .scaleAspectFit
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.image = UIImage(named: "icPointerRight")
    }

    override func setupConstraints() {
        leagueLogo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(32)
        }
        leagueCountry.snp.makeConstraints {
            $0.leading.equalTo(leagueLogo.snp.trailing).offset(32)
            $0.top.bottom.equalToSuperview().inset(20)
        }
        arrowImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(leagueCountry.snp.trailing)
        }
        leagueName.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalTo(arrowImage.snp.trailing)
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }

    override func setupGestureRecognizers() {
    }

    override func setupBinding() {
    }
    
    func configure(league: League) {
        leagueLogo.image = UIImage(named: league.logo)
        leagueCountry.text = league.country
        leagueName.text = league.name
    }
}

struct LeagueViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        LeagueView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct LeagueView_Previws: PreviewProvider {
    static var previews: some View {
        LeagueViewRepresentable().frame(height: 56)
    }
}
