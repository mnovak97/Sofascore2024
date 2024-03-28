import Foundation
import SofaAcademic
import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let settingsLabel: UILabel = .init()
    private let dismissButton: UIButton = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
    }
    
    @objc private func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: BaseViewProtocol
extension SettingsViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(settingsLabel)
        view.addSubview(dismissButton)
    }
    
    func setupConstraints() {
        settingsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(settingsLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        settingsLabel.text = "Settings"
        settingsLabel.textAlignment = .center
        dismissButton.setTitleColor(.systemBlue, for: .normal)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }
}
