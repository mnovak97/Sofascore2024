import UIKit
import SnapKit

class ViewController: UIViewController {

    let eventRespository = EventRepository(dataSource: MockData())
    let leagueView: LeagueView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(leagueView)
        leagueView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }
        eventRespository.fetch { events in
            guard let events = events else {
                print("Error")
                return
            }
                
            var previousEventView: UIView?
            for event in events {
                let eventView = EventView()
                eventView.configure(event)
                self.view.addSubview(eventView)
                
                eventView.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(56)
                    
                    if let previousView = previousEventView {
                        make.top.equalTo(previousView.snp.bottom)
                    } else {
                        make.top.equalTo(self.leagueView.snp.bottom)
                    }
                }
                previousEventView = eventView
            }
        }
    }
}
