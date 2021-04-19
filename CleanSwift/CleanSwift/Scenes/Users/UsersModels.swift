enum Users {
    enum InitialSetup {
        struct Request { }
        
        struct Response {
            let users: [User]
        }
        
        struct ViewModel {
            let users: [UsersTableCellViewModel]
        }
    }
}
