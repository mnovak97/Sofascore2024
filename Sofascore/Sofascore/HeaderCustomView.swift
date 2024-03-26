import Foundation
import SwiftUI
import SofaAcademic
import SnapKit

class HeaderCustomView: BaseView {
    
    private let logo: UIImageView = .init()
    private let cupImage: UIImageView = .init()
    private let settings: UIImageView = .init()
    
    override func addViews() {
        addSubview(logo)
        addSubview(cupImage)
        addSubview(settings)
    }
    
    override func setupConstraints() {
        logo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(cupImage.snp.leading)
        }
        cupImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalTo(settings.snp.leading).offset(-24)
        }
        settings.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func styleViews() {
        backgroundColor = Colors.colorPrimaryDefault
        logo.image = UIImage(named: "sofascoreLockup")
        cupImage.image = UIImage(named: "icon2")
        settings.image = UIImage(named: "icon1")
    }
}

struct HeaderCustomViewRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        return HeaderCustomView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

struct HeaderCustomView_Previws: PreviewProvider {
    static var previews: some View {
        HeaderCustomViewRepresentable().frame(height: 48)
    }
}
