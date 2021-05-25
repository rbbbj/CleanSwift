protocol BasePresentationLogic: AnyObject {
    func presentError()
    func presentError(response: BaseModels.Error.Response)
    func displayLoadingProgress()
}

class BasePresenter<T: BaseDisplayLogic>: BasePresentationLogic {
    weak var viewController: T?
    
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func presentError() {
        presentError(response: BaseModels.Error.Response())
    }
    
    func presentError(response: BaseModels.Error.Response) {
        let viewModel = BaseModels.Error.ViewModel(title: response.title, message: response.message)
        viewController?.displayError(viewModel: viewModel)
    }
    
    func displayLoadingProgress() {
        viewController?.displayLoadingProgress()
    }
}
