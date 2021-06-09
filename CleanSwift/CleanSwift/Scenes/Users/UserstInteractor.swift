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
        networkingWorker.fetchUsers() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.save(users: users)

                let response = Users.InitialSetup.Response(users: users)
                self.presenter.presentInitialSetup(response: response)
            case .failure(.networkFailure(let statusCode)):
                let error = BaseModels.Error.Response(message: DataLoadingError.networkFailure(statusCode: statusCode).localizedDescription)
                self.presenter.presentError(response: error)
            case .failure(.invalidData):
                let error = BaseModels.Error.Response(message: DataLoadingError.invalidData.localizedDescription)
                self.presenter.presentError(response: error)
            }
        }
    }
    
    func save(users: [User]) {
        usersRealmRepository.add(users: users.map({ $0.asRealm() }))
    }
}
