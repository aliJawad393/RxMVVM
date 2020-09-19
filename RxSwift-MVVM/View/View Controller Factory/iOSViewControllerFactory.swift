
import Foundation
import UIKit

final class iOSViewControllerFactory: ViewControllerFactory {
    
    private let networkManager: NetworkManagerProtocol
    private let databaseManager: CoreDataManager
    
    public init(databaseManager: CoreDataManager, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.databaseManager = databaseManager
    }
    
    func postsListViewController(selectionHandler: @escaping (PresentableFeedItem) -> Void) -> UIViewController {
        let networkService = ServiceFetchDataFromNetworkAndSaveToDatabase(networkDataFetcher: networkManager, databaseManager: PostsListDatabaseManager(databaseManager: databaseManager))
        let postsDbData: [PresentableFeedItem]? = PostsListDatabaseManager(databaseManager: databaseManager).fetchData()
        
        let viewModel = PostsListViewModel(postsData: postsDbData, dataService: networkService)

           return PostsListViewController(viewModel: viewModel, selectionHandler: selectionHandler)
    }
    
    func postDetailViewController(data: PresentableFeedItem) -> UIViewController {
        return PostDetailViewController(data: data)
    }

}
