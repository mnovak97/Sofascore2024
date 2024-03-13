import Foundation

protocol DataSourceProtocol {
    
    func fetch(completion: @escaping ([Event]?) -> Void)
    
}
