import Foundation
import SwiftUI
import SofaAcademic

class LeagueView: BaseView {
    
    let leagueLogo: UIImageView = .init()
    let leagueConutry: UILabel = .init()
    let arrowImage: UIImageView = .init()
    let leagueName: UILabel = .init()
    
    override func addViews() {
        addSubview(leagueLogo)
        addSubview(leagueConutry)
        addSubview(arrowImage)
        addSubview(leagueName)
    }
    
    override func styleViews() {
        leagueConutry.font = ApplicationsFonts.headline3
        leagueName.font = ApplicationsFonts.headline3
        leagueName.textColor = ApplicationColors.secondaryColor
    }

    override func setupConstraints() {
        leagueLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        leagueConutry.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(leagueLogo.snp.trailing).offset(32)
        }
        arrowImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalTo(leagueConutry.snp.trailing)
        }
        leagueName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(arrowImage.snp.trailing)
        }
    }

    override func setupGestureRecognizers() {
    }

    override func setupBinding() {
        leagueLogo.image = UIImage(named: "laliga")
        leagueConutry.text = "Spain"
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
