
import Foundation
import UIKit

protocol ViewControllerFactory {
    func postsListViewController(selectionHandler: @escaping (PresentableFeedItem) -> Void) -> UIViewController
    func postDetailViewController(data: PresentableFeedItem) -> UIViewController
}
