import Foundation

class UsersConfigurator: NSObject {
    static let shared = UsersConfigurator()
    private override init() {}
    
    func configure(_ viewController: UsersViewController) {
        let interactor = UsersInteractor()
        let presenter = UsersPresenter<UsersViewController>(viewController: viewController)
        let router = UsersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.usersRealmRepository = UsersRealmRepository()
        interactor.networkingWorker = UsersNetworkingWorker(useMock: false)
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
