import UIKit

protocol BaseDisplayLogic: AnyObject {
    func displayLoadingProgress()
    func displayError(viewModel: BaseModels.Error.ViewModel)
}

class BaseViewController: UIViewController, BaseDisplayLogic {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dch_checkDeallocation()
    }
    
    // MARK: BaseDisplayLogic
    
    func displayError(viewModel: BaseModels.Error.ViewModel) {
        stopAnimating()

        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        
    }
    
    func displayLoadingProgress() {
        startAnimating()
    }
}

// MARK: Activity Indicator Management

extension BaseViewController {
    func startAnimating() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator?.center = view.center
            activityIndicator?.hidesWhenStopped = true
            if let activityIndicator = activityIndicator {
                view.addSubview(activityIndicator)
            }
        }
        activityIndicator?.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator?.stopAnimating()
    }
}
