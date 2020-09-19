
import Foundation
import RxSwift
import CoreData

final class PostsListDatabaseManager: DatabaseManagerProtocol {
    private let databaseManager: CoreDataManager
    private let entityName = "PostItemDb"
    
    init(databaseManager: CoreDataManager) {
        self.databaseManager = databaseManager
    }
    
    func saveData<D>(data: D) {
        databaseManager.deleteAllData(entity: entityName) // Remove previously added data
        if let posts = (data as? PostsListResponse)?.data {
            for post in posts {
                let newPost = databaseManager.createRow(entitiy: entityName) as? PostItemDb
                newPost?.caption = post.caption ?? ""
                newPost?.mediaUrl = post.media_url
                newPost?.commentCount = Int32(post.comments ?? 0)
                newPost?.likesCount = Int32(post.likes ?? 0)
            }
            
            databaseManager.saveContext()
        }
        
    }
    
    func fetchData<T>() -> [T]? {
        let result = databaseManager.fetchAllRows(entity: entityName) as? [PostItemDb]
        let presentableModel =  result?.map({ (data) -> PresentableFeedItem in
            return dbModelToPresentableModel(data: data)
        })
        
        return presentableModel as? [T]
    }
    
}

//MARK: Data Conversion
extension PostsListDatabaseManager {
    private func dbModelToPresentableModel(data: PostItemDb) -> PresentableFeedItem {
        return PresentableFeedItem(caption: data.caption ?? "", mediaUrl: data.mediaUrl ?? "", comments: Int(data.commentCount), likes: Int(data.likesCount))
    }
}
