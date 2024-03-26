import UIKit
import SofaAcademic
import SnapKit

class MainViewController: UIViewController {
    
    private let safeAreaHeader: SafeAreaHeaderView = .init()
    private let customHeader: HeaderCustomView = .init()
    private let tabView: CustomTabView = .init()
    private let containerView: UIView = .init()
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabView.delegate = self
        addViews()
        setupConstraints()
        styleViews()
        showViewController(for: .football)
    }
    
    private func showViewController(for sport: Sport) {
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = .push
        animation.subtype = .fromRight
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
        containerView.layer.add(animation, forKey: "viewControllerTransition")
            
        currentViewController?.removeFromParent()
        currentViewController?.view.removeFromSuperview()
                
        let eventsViewController = EventsViewController(sport: sport)
        addChild(eventsViewController)
        containerView.addSubview(eventsViewController.view)
        eventsViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        eventsViewController.didMove(toParent: self)
        currentViewController = eventsViewController
    }
    
}

extension MainViewController: BaseViewProtocol {
    func addViews() {
        view.addSubview(safeAreaHeader)
        view.addSubview(customHeader)
        view.addSubview(tabView)
        view.addSubview(containerView)
    }
    
    func setupConstraints() {
        safeAreaHeader.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.top)
            $0.leading.equalTo(view.safeAreaInsets.left)
            $0.trailing.equalTo(view.safeAreaInsets.right)
        }
        customHeader.snp.makeConstraints {
            $0.top.equalTo(safeAreaHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(tabView.snp.top)
        }
        tabView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top)
        }
        containerView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
    }
    
}

extension MainViewController: CustomTabViewDelegate {
    func didSelectTab(for sport: Sport) {
        showViewController(for: sport)
    }
}
