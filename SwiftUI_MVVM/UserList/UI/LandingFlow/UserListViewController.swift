//
//  UserListViewController.swift
//  SwiftUI_MVVM
//
//  Created by Gaurav Gandhale on 05/06/20.
//  Copyright © 2020 Gaurav Gandhale. All rights reserved.
//

import SwiftUI
import Combine

class UserListViewController: UIHostingController<UserListView> {

    private var subscriber:AnyCancellable?
    var viewModel: UserListViewModel = UserListViewModel()

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(rootView: UserListView) {
        super.init(rootView: rootView)
        viewModel.delegateUserListViewModel = self
        attachSubscriber()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUsers()
    }

    private func attachSubscriber() {
        viewModel.addSubscriber(passThroughObject: rootView.tapEventPublisher)
    }

    func fetchUsers() {
        viewModel.fetchSource { [weak self] (users) in
            guard let users = users else { return }
            self?.rootView.source.users.removeAll()
            self?.rootView.source.users = users
        }
    }
}

extension UserListViewController: UserListViewModelProtocol {
    func navigateTiDetailScreen(with userDetail: UserDTO) {
        let detailView = UserDetailView(user: userDetail)
        let detailViewController = UserDetailViewController(rootView: detailView)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
