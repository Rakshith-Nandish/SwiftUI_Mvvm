

import SwiftUI
import Combine

struct UserListView: View {
    
    @ObservedObject var source: UserModelSource

    var tapEventPublisher = PassthroughSubject<UserDTO,Error>()
    var body: some View {
        VStack() {
            List(source.users) { user in
                UserRowView(user: user).frame(height: 100)
                    .gesture(TapGesture().onEnded({ _ in
                        self.tapEventPublisher.send(user.user)
                    }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(source: UserModelSource())
    }
}
