import Foundation
import UIKit
import SofaAcademic
import SnapKit

class SafeAreaHeaderView: BaseView {
    
    private let safeAreaHeader: UIView = .init()
    
    override func addViews() {
        addSubview(safeAreaHeader)
    }
    
    override func styleViews() {
        safeAreaHeader.backgroundColor = Colors.colorPrimaryDefault
    }
    
    override func setupConstraints() {
        safeAreaHeader.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
