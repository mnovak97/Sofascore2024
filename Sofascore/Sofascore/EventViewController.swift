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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        fetchEvents()
    }
    
    private func fetchEvents() {
        eventRespository.fetch { sections in
            if let sections {
                self.sectionsData = sections
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension EventsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionsData[section].events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LeagueCell.identifier, for: indexPath) as? LeagueCell else {
                return UICollectionReusableView()
            }
            
            let league = sectionsData[indexPath.section].league
            headerView.configure(league: league)
            
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let separatorView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SeparatorView", for: indexPath)
            separatorView.frame.size = CGSize(width: collectionView.frame.width, height: 1)
            separatorView.backgroundColor = Colors.onSurfaceLv4
            return separatorView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.identifier, for: indexPath) as? EventCell else {
            return UICollectionViewCell()
        }
        
        let event = sectionsData[indexPath.section].events[indexPath.row]
        cell.configure(event: event)
        
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension EventsViewController: UICollectionViewDelegate {
}

//MARK: UICollectionViewDelegateFlowLayout
extension EventsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 56)
    }
}

//MARK: BaseViewProtocol
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
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(LeagueCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LeagueCell.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "SeparatorView")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
