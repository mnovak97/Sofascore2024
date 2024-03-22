import Foundation
import SofaAcademic
import SnapKit
import UIKit

class EventCell: UICollectionViewCell {

    private let eventView: EventView = EventView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(event: Event) {
        eventView.configure(event)
    }
}
extension EventCell: BaseViewProtocol {
    func addViews() {
        addSubview(eventView)
    }

    func setupConstraints() {
        eventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
