import Swinject
import SwinjectAutoregistration

final class DependencyContainer {
    static private(set) var container: Container?
    
    static func registerAndRetrieveContainer() -> Container {
        let container = Container()
        registerPersistanceObjects(container: container)
        registerScenes(container: container)
        self.container = container
        return container
    }
    
    static func registerPersistanceObjects(container: Container) {
        container.autoregister(UsersRealmPersistable.self, initializer: UsersRealmRepository.init)
        // More Services
    }
    
    static func registerScenes(container: Container) {
        UsersConfigurator.register(container: container)
        // More Scenes
    }
}
