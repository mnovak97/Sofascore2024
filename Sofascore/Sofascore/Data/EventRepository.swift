import Foundation

class EventRepository {
    
    private let dataSource: DataSourceProtocol
    
    init(dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func fetch(completion: @escaping ([Section]?) -> Void) {
        dataSource.fetch(completion: completion)
    }
}
