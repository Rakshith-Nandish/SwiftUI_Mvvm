//

import SwiftUI

struct UserDetailView: View {

    struct Constant {
        static let placeholder = UIImage(named: "placeholder")!
    }

    var userDetail: UserDTO

    @ObservedObject var avatar: ImageUrlLoader

    init(user: UserDTO) {
        self.userDetail = user
        avatar = ImageUrlLoader(url: userDetail.avatar)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(uiImage: (((self.avatar.imageData.isEmpty)
            ? Constant.placeholder
            : UIImage(data: self.avatar.imageData)) ?? Constant.placeholder))
            .resizable()
                .frame(width: 200, height: 200, alignment: .top)
            .clipShape(Circle())
            .shadow(radius: 10)
                .overlay(Circle().stroke(Color.black,lineWidth: 3))
            Spacer().frame(height: 50)
            HStack {
                Text("Name:").font(.system(size:20)).bold()
                Text(userDetail.first_name + " " + userDetail.last_name).font(.system(size: 18))
            }
            HStack {
                Text("Email:").font(.system(size:20)).bold()
                Text(userDetail.email)
            }
            HStack {
                Text("Gender:").font(.system(size:20)).bold()
                Text(userDetail.gender)
            }
            Spacer()
        }
    }
}
