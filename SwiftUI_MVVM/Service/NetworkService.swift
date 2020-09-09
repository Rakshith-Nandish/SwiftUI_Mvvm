

import Foundation
import os.log

protocol NetworkServiceProtocol {
    func fetchDataModel<T: Decodable>(_ urlString: String, completion: @escaping (T?) -> ())
    func fetchImage(_ urlString: String, completion: @escaping (Data?) -> ())
}

class NetworkService: NetworkServiceProtocol {
    func fetchDataModel<T: Decodable>(_ urlString: String, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let dto = try JSONDecoder().decode(T.self, from: data)
                completion(dto)
            } catch _ {
                os_log("*** Failed to parse.", log: .default, type: .debug)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchImage(_ urlString: String, completion: @escaping (Data?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let rawdata = data else {
                completion(nil)
                return
            }
            completion(rawdata)
        }.resume()
    }
}
