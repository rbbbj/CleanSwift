import RealmSwift
import Realm

protocol UsersBusinessLogic {
    func initialSetup()
}

protocol UsersDataStore { }

class UsersInteractor: UsersBusinessLogic, UsersDataStore {
    var presenter: UsersPresentationLogic! = nil
    var usersRealmRepository: UsersRealmPersistable! = nil
    var networkingWorker: UsersNetworkingWorker! = nil
    
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
        Task {
            do {
                let users = try await networkingWorker.fetchUsers()
                self.save(users: users)

                let response = Users.InitialSetup.Response(users: users)
                await MainActor.run {
                    self.presenter.presentInitialSetup(response: response)
                }
            } catch DataLoadingError.networkFailure(let statusCode) {
                let errorResponse = BaseModels.Error.Response(message: "Network failure with status code: \(statusCode)")
                await MainActor.run {
                    self.presenter.presentError(response: errorResponse)
                }
            } catch DataLoadingError.invalidData {
                let errorResponse = BaseModels.Error.Response(message: "Invalid data received from the server.")
                await MainActor.run {
                    self.presenter.presentError(response: errorResponse)
                }
            } catch {
                let errorResponse = BaseModels.Error.Response(message: "An unknown error occurred.")
                await MainActor.run {
                    self.presenter.presentError(response: errorResponse)
                }
            }
        }
    }
    
    func save(users: [User]) {
        usersRealmRepository.add(users: users.map({ $0.asRealm() }))
    }
}
