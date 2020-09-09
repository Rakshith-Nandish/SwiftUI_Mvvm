

import Foundation
import Combine

protocol UserListViewModelProtocol : class {
    func navigateTiDetailScreen(with userDetail: UserDTO)
}

class UserListViewModel {
    
    //Model
    
    
    //Service
    let service: NetworkServiceProtocol? = ServiceLocator.instance.get(service: NetworkServiceProtocol.self)
    private var subscriber:AnyCancellable?

    weak var delegateUserListViewModel: UserListViewModelProtocol?

    struct Constant {
        static let users_api = "https://my.api.mockaroo.com/users.json?key=030543b0"
    }
    
    
    func fetchSource(completion: @escaping ([UserModel]?) -> ()) {        
        service?.fetchDataModel(Constant.users_api,
                                completion: { (users: [UserDTO]?) in
                                    guard let usersDTO = users else { return }
                                    DispatchQueue.main.async {
                                        let users = usersDTO.map({ UserModel(user: $0) })
                                        completion(users)
                                    }
        })
    }

    func addSubscriber(passThroughObject: PassthroughSubject<UserDTO,Error>) {
        subscriber = passThroughObject.sink(receiveCompletion: {_ in },
                                         receiveValue: { (user) in
                                            self.delegateUserListViewModel?.navigateTiDetailScreen(with: user)
        })
    }
}
