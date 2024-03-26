import Foundation
import SofaAcademic
import SnapKit
import UIKit

class CustomTabView: BaseView {
    
    private let horizontalStack: UIStackView = .init()
    private let footballTab: TabViewItem = .init()
    private let basketballTab: TabViewItem = .init()
    private let amFootballTab: TabViewItem = .init()
    private var currentSport: Sport = .football
    private var selectedTab: TabViewItem?
    var delegate: CustomTabViewDelegate?
    
    override func addViews() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(footballTab)
        horizontalStack.addArrangedSubview(basketballTab)
        horizontalStack.addArrangedSubview(amFootballTab)
    }
    
    override func styleViews() {
        backgroundColor = Colors.colorPrimaryDefault
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        footballTab.configure(tabItem: TabItem(logo: "icon", sportName: "Football"), isSelected: false)
        basketballTab.configure(tabItem: TabItem(logo: "iconBasketball", sportName: "Basketball"), isSelected: false)
        amFootballTab.configure(tabItem: TabItem(logo: "iconAmericanFootball", sportName: "Am. Football"), isSelected: false)
        
        footballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabSelected)))
        basketballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabSelected)))
        amFootballTab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabSelected)))
    }
    
    override func setupConstraints() {
        horizontalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func tabSelected(sender: UITapGestureRecognizer) {
        guard let tabView = sender.view as? TabViewItem else { return }
            
        switch tabView {
        case footballTab:
            selectTab(for: .football)
        case basketballTab:
            selectTab(for: .basketball)
        case amFootballTab:
            selectTab(for: .amFootball)
        default:
            break
        }
    }
        
    func selectTab(for sport: Sport) {
        guard sport != currentSport else { return }
        currentSport = sport
        delegate?.didSelectTab(for: sport)
    }
    
}

protocol CustomTabViewDelegate: AnyObject {
    func didSelectTab(for sport: Sport)
}
