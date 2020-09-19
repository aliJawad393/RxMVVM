
import Foundation
import UIKit

protocol DnaInstaRouterProtocol {
    func navigateToPostsListViewController(selectionHandler: @escaping (PresentableFeedItem) -> Void)
    func navigateToPostDetailViewController(data: PresentableFeedItem)
}

final class DnaInstaRouter: DnaInstaRouterProtocol {
    
    private let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllerFactory
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func navigateToPostsListViewController(selectionHandler: @escaping (PresentableFeedItem) -> Void) {
        DispatchQueue.main.async {[weak self] in
            if let controller = self?.viewControllerFactory.postsListViewController(selectionHandler: selectionHandler) {
                self?.navigationController.pushViewController(controller, animated: false)
            }
        }
    }
    
    func navigateToPostDetailViewController(data: PresentableFeedItem) {
        DispatchQueue.main.async {[weak self] in
            if let controller = self?.viewControllerFactory.postDetailViewController(data: data) {
                self?.navigationController.pushViewController(controller, animated: true)
            }
        }
    }
    
}
