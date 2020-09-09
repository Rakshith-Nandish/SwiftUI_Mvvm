

import SwiftUI

struct UserDTO: Decodable {
    var uid: Int
    var first_name: String
    var last_name: String
    var email: String
    var gender: String
    var avatar: String
}

struct UserModel: Identifiable {
    var id = UUID()
    var user: UserDTO
}
