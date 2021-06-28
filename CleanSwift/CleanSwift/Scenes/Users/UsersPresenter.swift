protocol UsersPresentationLogic: BasePresentationLogic {
    func presentInitialSetup(response: Users.InitialSetup.Response)
}

class UsersPresenter<T: UsersDisplayLogic>: BasePresenter<T>, UsersPresentationLogic {
    func presentInitialSetup(response: Users.InitialSetup.Response) {
        let viewModels = response.users.map( { UsersTableCellViewModel(name: $0.name ?? "" ) })
        let viewModel = Users.InitialSetup.ViewModel(users: viewModels)
        viewController?.displayInitialSetup(viewModel: viewModel)
    }
}
