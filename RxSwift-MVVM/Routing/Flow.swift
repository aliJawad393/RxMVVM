
import Foundation

final class Flow {
    private let router: DnaInstaRouterProtocol
    private var data: FeedsListModel?
    init(router: DnaInstaRouterProtocol) {
        self.router = router
    }
    
    func start() {
        router.navigateToPostsListViewController {[weak self] (model) in
            self?.navigateToPostDetailViewController(data: model)
        }
    }
    
    func navigateToPostDetailViewController(data: PresentableFeedItem) {
        router.navigateToPostDetailViewController(data: data)
    }
}
