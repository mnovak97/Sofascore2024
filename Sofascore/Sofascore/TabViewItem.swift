import Foundation
import SwiftUI
import UIKit
import SofaAcademic
import SnapKit

class TabViewItem: BaseView {
    
    private let verticalStack: UIStackView = .init()
    private let sportLogo: UIImageView = .init()
    private let sportName: UILabel = .init()
    private let selector: UIView = .init()
    var isSelected: Bool = false {
        didSet {
            selector.backgroundColor = isSelected ? Colors.surfaceSurface1 : .clear
        }
    }
    
    override func addViews() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(sportLogo)
        verticalStack.addArrangedSubview(sportName)
        verticalStack.addArrangedSubview(selector)
    }
    
    override func setupConstraints() {
        verticalStack.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(8)
        }
        selector.snp.makeConstraints {
            $0.height.equalTo(4)
        }
    }
    
    override func styleViews() {
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        sportName.textColor = Colors.surfaceSurface1
        sportName.textAlignment = .center
        sportName.font = Fonts.body
        sportLogo.contentMode = .scaleAspectFit
    }
    
    func configure(tabItem: TabItem) {
        sportLogo.image = UIImage(named: tabItem.logo)
        sportName.text = tabItem.sportName
    }
}

struct TabViewItemRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let tabView = TabViewItem()
        tabView.configure(tabItem: TabItem(logo: "icon", sportName: "Football"))
        tabView.backgroundColor = Colors.colorPrimaryDefault
        return tabView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

struct TabViewItem_Previws: PreviewProvider {
    static var previews: some View {
        TabViewItemRepresentable().frame(width: 120, height: 48)
    }
}
