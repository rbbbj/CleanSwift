import Foundation
import Swinject

class UsersConfigurator: NSObject {
    private static func configure(_ viewController: UsersViewController, resolver: Resolver) {
        let presenter = UsersPresenter<UsersViewController>(viewController: viewController)
        let interactor = UsersInteractor(presenter: presenter,
                                         usersRealmRepository: resolver.resolve(UsersRealmPersistable.self)!)
        let router = UsersRouter()
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    static func register(container: Container) {
        container.storyboardInitCompleted(UsersViewController.self, initCompleted: { r, c in
            configure(c, resolver: r)
        })
    }
}
