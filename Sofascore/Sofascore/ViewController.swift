import UIKit
import SofaAcademic
import SnapKit

class ViewController: UIViewController {
    
    private let eventRespository = EventRepository(dataSource: MockData())
    private let leagueView: LeagueView = .init()
    private let eventStackView: UIStackView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        setupConstraints()
        styleViews()
        fetchEvents()
    }
    
    func fetchEvents() {
        eventRespository.fetch { events in
            guard let events = events else {
                print("Error")
                return
            }
                
            for event in events {
                let eventView = EventView()
                eventView.configure(event)
                self.eventStackView.addArrangedSubview(eventView)
            }
        }
    }
}

extension ViewController: BaseViewProtocol {
    
    func addViews() {
        view.addSubview(leagueView)
        view.addSubview(eventStackView)
    }
    
    func setupConstraints() {
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(eventStackView.snp.top)
        }
        
        eventStackView.snp.makeConstraints { make in
            make.top.equalTo(leagueView.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        eventStackView.axis = .vertical
    }
}
