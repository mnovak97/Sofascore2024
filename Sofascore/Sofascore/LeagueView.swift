import Foundation
import SwiftUI
import SofaAcademic

class LeagueView: BaseView {
    
    private let leagueHorizontalStack: UIStackView = .init()
    private let leagueLogo: UIImageView = .init()
    private let leagueNameHorizontalStack: UIStackView = .init()
    private let leagueCountry: UILabel = .init()
    private let arrowImage: UIImageView = .init()
    private let leagueName: UILabel = .init()
    
    override func addViews() {
        addSubview(leagueHorizontalStack)
        leagueHorizontalStack.addArrangedSubview(leagueLogo)
        leagueHorizontalStack.addArrangedSubview(leagueNameHorizontalStack)
        leagueNameHorizontalStack.addArrangedSubview(leagueCountry)
        leagueNameHorizontalStack.addArrangedSubview(arrowImage)
        leagueNameHorizontalStack.addArrangedSubview(leagueName)
    }
    
    override func styleViews() {
        leagueHorizontalStack.axis = .horizontal
        leagueHorizontalStack.spacing = 32
        leagueCountry.font = Fonts.headline3
        leagueName.font = Fonts.headline3
        leagueName.textColor = Colors.onSurfaceLv2
        leagueLogo.contentMode = .scaleAspectFit
        arrowImage.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        leagueHorizontalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        leagueLogo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(32)
        }
        leagueNameHorizontalStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
    }

    override func setupBinding() {
        leagueLogo.image = UIImage(named: "laliga")
        leagueCountry.text = "Spain"
        arrowImage.image = UIImage(named: "icPointerRight")
        leagueName.text = "LaLiga"
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
