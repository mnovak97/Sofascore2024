import Foundation
import SwiftUI
import SofaAcademic
import SnapKit

class HeaderCustomView: BaseView {
    
    private let logo: UIImageView = .init()
    private let horizontalStack: UIStackView = .init()
    private let cupImage: UIImageView = .init()
    private let settings: UIImageView = .init()
    var delegate: HeaderCustomViewDelegate?
    
    override func addViews() {
        addSubview(logo)
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(cupImage)
        horizontalStack.addArrangedSubview(settings)
    }
    
    override func setupConstraints() {
        logo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(horizontalStack.snp.leading)
        }
        horizontalStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc private func settingsTapped() {
        delegate?.settingsImageTapped()
    }
    
    override func styleViews() {
        backgroundColor = Colors.colorPrimaryDefault
        horizontalStack.spacing = 16
        logo.image = UIImage(named: "sofascoreLockup")
        cupImage.image = UIImage(named: "icon2")
        cupImage.contentMode = .scaleAspectFit
        settings.image = UIImage(named: "icon1")
        settings.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(settingsTapped))
        settings.isUserInteractionEnabled = true
        settings.addGestureRecognizer(tapGesture)
    }
}

protocol HeaderCustomViewDelegate: AnyObject {
    func settingsImageTapped()
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
