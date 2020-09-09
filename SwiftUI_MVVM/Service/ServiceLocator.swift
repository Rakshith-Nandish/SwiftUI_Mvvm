

import Foundation

public protocol ServiceLocatorProtocol {
    func get<T>(service: T.Type) -> T?
}

public class ServiceLocator: ServiceLocatorProtocol {

    public static let instance = ServiceLocator()
    
    private init() {}
    
    public func get<T>(service: T.Type) -> T? {
        switch String(describing: service) {
        case String(describing: NetworkServiceProtocol.self):
            return NetworkService() as? T
        default:
            return nil
        }
    }
}
