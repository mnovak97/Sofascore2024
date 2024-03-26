import Foundation
import SwiftUI
import UIKit
import SofaAcademic
import SnapKit

class TabViewItem: BaseView {
    
    private let sportLogo: UIImageView = .init()
    private let sportName: UILabel = .init()
    private let selector: UIView = .init()
    var isSelected: Bool = false {
        didSet {
            selector.isHidden = !isSelected
        }
    }
    
    override func addViews() {
        addSubview(sportLogo)
        addSubview(sportName)
        addSubview(selector)
    }
    
    override func setupConstraints() {
        sportLogo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview()
            $0.size.equalTo(16)
        }
        sportName.snp.makeConstraints {
            $0.top.equalTo(sportLogo.snp.bottom).offset(4)
            $0.bottom.equalTo(selector.snp.top).inset(4)
            $0.leading.trailing.equalToSuperview()
        }
        selector.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(4)
        }
    }
    
    override func styleViews() {
        sportName.textColor = Colors.surfaceSurface1
        sportName.textAlignment = .center
        sportName.font = Fonts.body
        sportLogo.contentMode = .scaleAspectFit
        selector.backgroundColor = Colors.surfaceSurface1
        selector.isHidden = true
    }
    
    func configure(tabItem: TabItem, isSelected: Bool) {
        sportLogo.image = UIImage(named: tabItem.logo)
        sportName.text = tabItem.sportName
        self.isSelected = isSelected
    }
    
}

struct TabViewItemRepresentable: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let tabView = TabViewItem()
        tabView.configure(tabItem: TabItem(logo: "icon", sportName: "Football"), isSelected: true)
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
