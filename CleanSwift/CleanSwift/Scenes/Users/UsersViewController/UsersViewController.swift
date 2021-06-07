import UIKit

protocol UsersDisplayLogic: BaseDisplayLogic {
    func displayInitialSetup(viewModel: Users.InitialSetup.ViewModel)
}

class UsersViewController: BaseViewController {
    @IBOutlet private weak var usersTableView: UITableView!

    var interactor: UsersBusinessLogic?
    var router: (NSObjectProtocol & UsersRoutingLogic & UsersDataPassing)?
    private var userCellModels: [UsersTableCellViewModel]?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        UsersConfigurator.shared.configure(self)
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
}

// MARK: - UsersDisplayLogic

extension UsersViewController: UsersDisplayLogic {
    func displayInitialSetup(viewModel: Users.InitialSetup.ViewModel) {
        stopAnimating()

        userCellModels = viewModel.users
        usersTableView.reloadData()
    }
}

// MARK: - Navigation

extension UsersViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}
    
// MARK: - UITableViewDataSource, UITableViewDelegate

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCellModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return userCell(atIndexPath: indexPath)
    }
}

// MARK: - Privates

private extension UsersViewController {
    func initialSetup() {
        setupTableView()
        interactor?.initialSetup()
    }
    
    func setupTableView() {
        let nib = UINib(nibName: String(describing: UsersTableCell.self), bundle: Bundle(for: type(of: self)))
        usersTableView.register(nib, forCellReuseIdentifier: "UsersTableCell")
    }
    
    func userCell(atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = usersTableView.dequeueReusableCell(withIdentifier: "UsersTableCell", for: indexPath) as? UsersTableCell else {
            fatalError("Could not dequeue cell of type UsersTableCell")
        }
        if let usersCellModel = userCellModels?[indexPath.row] {
            cell.configure(with: usersCellModel)
        }
        
        return cell
    }
}
