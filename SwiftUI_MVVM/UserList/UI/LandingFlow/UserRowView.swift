//
//  UserRowView.swift
//  SwiftUI_MVVM
//
//  Created by Gaurav Gandhale on 02/06/20.
//  Copyright © 2020 Gaurav Gandhale. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    
    struct Constant {
        static let placeholder = UIImage(named: "placeholder")!
    }
    
    var userModel: UserModel
    
    @ObservedObject var avatar: ImageUrlLoader
    
    init(user: UserModel) {
        self.userModel = user
        avatar = ImageUrlLoader(url: userModel.user.avatar)
    }
    
    var body: some View {
        return GeometryReader { geometry in
            HStack() {
                Image(uiImage: (((self.avatar.imageData.isEmpty)
                    ? Constant.placeholder
                    : UIImage(data: self.avatar.imageData)) ?? Constant.placeholder))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center)
                Spacer()
                VStack() {
                    Text("\(self.userModel.user.first_name) \(self.userModel.user.last_name)")
                    Text("\(self.userModel.user.email)")
                    
                }
                Spacer()
                Text("\(self.userModel.user.gender)")
                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
        }
    }    
}
