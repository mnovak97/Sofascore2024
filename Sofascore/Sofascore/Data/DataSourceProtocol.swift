import Foundation

protocol DataSourceProtocol {
    
    func fetch(completion: @escaping ([Section]?) -> Void)
    
}
