
import Combine

class UserModelSource: ObservableObject {
    @Published var users: [UserModel] = []
}
