import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController {
    
    private let customHeader: HeaderCustomView = .init()
    private let tabView: CustomTabView = .init()
    private let containerView: UIView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        tabView.selectTab(for: Sport(rawValue: UserDefaults.standard.integer(forKey: "sport")) ?? .football)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        customHeader.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        customHeader.isHidden = true
    }
    
    private func showViewController(for sport: Sport) {
        let eventsViewController = EventsViewController(sport: sport)
        add(eventsViewController, containerView)
        eventsViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: UIViewController
extension UIViewController {
    
    func add(_ child: UIViewController,_ view: UIView) {
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        view.layer.add(animation, forKey: "viewControllerTransition")
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

//MARK: BaseViewProtocol
extension MainViewController: BaseViewProtocol {
    
    func addViews() {
        navigationController?.navigationBar.addSubview(customHeader)
        view.addSubview(tabView)
        view.addSubview(containerView)
    }
    
    func setupConstraints() {
        customHeader.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tabView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(containerView.snp.top)
        }
        containerView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.colorPrimaryDefault
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        tabView.delegate = self
        customHeader.delegate = self
    }
    
    @objc private func settingsTapped() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
}

//MARK: CustomTabViewDelegate
extension MainViewController: CustomTabViewDelegate {
    
    func didSelectTab(for sport: Sport) {
        showViewController(for: sport)
    }
}

//MARK: HeaderCustomViewDelegate
extension MainViewController: HeaderCustomViewDelegate {
    
    func settingsImageTapped() {
        let vc = SettingsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
}
