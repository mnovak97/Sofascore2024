import Foundation
import SofaAcademic
import SnapKit
import UIKit

class EventsViewController: UIViewController {
    
    private var sectionsData: [Section] = []
    private let eventRespository = EventRepository(dataSource: MockData())
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        fetchEvents()
    }
    
    func fetchEvents() {
        eventRespository.fetch { sections in
            if let sections {
                self.sectionsData = sections
            }
        }
    }
}

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsData[section].events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Strings.leagueCell, for: indexPath) as? LeagueCell else {
                return UICollectionReusableView()
            }
            
            let league = sectionsData[indexPath.section].league
            headerView.configure(league: league)
            
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let separatorView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Strings.separatorView, for: indexPath)
            separatorView.backgroundColor = Colors.onSurfaceLv4
            return separatorView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.eventCell, for: indexPath) as? EventCell else {
            return UICollectionViewCell()
        }
        
        let event = sectionsData[indexPath.section].events[indexPath.row]
        cell.configure(event: event)
        
        return cell
    }
}

extension EventsViewController: BaseViewProtocol {
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func styleViews() {
        view.backgroundColor = .white
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: Strings.eventCell)
        collectionView.register(LeagueCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Strings.leagueCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Strings.separatorView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
