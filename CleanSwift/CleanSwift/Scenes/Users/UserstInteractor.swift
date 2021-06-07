import RealmSwift
import Realm

protocol UsersBusinessLogic {
    func initialSetup()
}

protocol UsersDataStore { }

class UsersInteractor: UsersBusinessLogic, UsersDataStore {
    var presenter: UsersPresentationLogic! = nil
    var usersRealmRepository: UsersRealmPersistable! = nil
    private var networkingWorker = UsersNetworkingWorker()
    
    func initialSetup() {
        presenter.displayLoadingProgress()
        getUsers()
    }
}

private extension UsersInteractor {
    func getUsers() {
        if let rmUsers = usersRealmRepository.retrieveUsers() {
            processUsersFromDB(with: rmUsers)
        } else {
            fetchUsersFromServer()
        }
    }
    
    func processUsersFromDB(with rmUsers: Results<RMUser>) {
        let users: [User] = rmUsers.compactMap{ (try? $0.asDomain()) }
        
        let response = Users.InitialSetup.Response(users: users)
        self.presenter.presentInitialSetup(response: response)
    }
    
    func fetchUsersFromServer() {
        networkingWorker.fetchUsers() { [weak self] users, error in
            guard let self = self else { return }
            
            if error != nil {
                let error = BaseModels.Error.Response(message: error?.localizedDescription ?? "Data Error\nPlease try again.")
                self.presenter.presentError(response: error)
            } else {
                guard let users = users else {
                    return
                }
                
                self.save(users: users)
                
                let response = Users.InitialSetup.Response(users: users)
                self.presenter.presentInitialSetup(response: response)
            }
        }
    }
    
    func save(users: [User]) {
        usersRealmRepository.add(users: users.map({ $0.asRealm() }))
    }
}
