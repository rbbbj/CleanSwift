import UIKit
import NVActivityIndicatorView

protocol BaseDisplayLogic: AnyObject {
    func displayLoadingProgress()
    func displayError(viewModel: BaseModels.Error.ViewModel)
}

class BaseViewController: UIViewController, BaseDisplayLogic {
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dch_checkDeallocation()
    }
    
    // MARK: BaseDisplayLogic
    
    func displayError(viewModel: BaseModels.Error.ViewModel) {
        stopAnimating()
        ErrorMessage.addCenteredMessage(title: viewModel.title, message: viewModel.message)
    }
    
    func displayLoadingProgress() {
        startAnimating()
    }
}

// For NVActivityIndicatorView blocker

extension BaseViewController: NVActivityIndicatorViewable { }
