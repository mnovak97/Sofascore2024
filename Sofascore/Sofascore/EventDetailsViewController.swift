import Foundation
import SofaAcademic
import UIKit
import SnapKit

class EventDetailsViewController: UIViewController {
    
    private let detailsLabel: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: BaseViewProtocol
extension EventDetailsViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(detailsLabel)
    }
    
    func setupConstraints() {
        detailsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        detailsLabel.text = "Details"
        detailsLabel.textAlignment = .center
    }
}
