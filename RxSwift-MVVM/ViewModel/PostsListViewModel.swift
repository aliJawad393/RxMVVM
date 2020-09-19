
import Foundation
import RxSwift
import RxCocoa

struct PresentableFeedItem {
    let caption: String
    let mediaUrl: String
    let comments: Int
    let likes: Int
}

protocol PostsListViewModelProtocol {
    func getSourceData() -> Observable<[PresentableFeedItem]>
}

final class PostsListViewModel: PostsListViewModelProtocol {
    private var data: BehaviorRelay<[PresentableFeedItem]>
    private let dataService: DataServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(postsData: [PresentableFeedItem]?, dataService: DataServiceProtocol) {
        self.data = BehaviorRelay<[PresentableFeedItem]>(value: postsData ?? [PresentableFeedItem]())
        self.dataService = dataService
        
        let obs: Observable<PostsListResponse?> = self.dataService.fetchData()
        
        obs.map({ (response) -> [PresentableFeedItem]? in
            return response?.data?.map({ (value) -> PresentableFeedItem in
                return PresentableFeedItem(caption: value.caption ?? "", mediaUrl: value.media_url ?? "", comments: value.comments ?? 0, likes: value.likes ?? 0)
            })

        }).subscribe(onNext: {[weak self] feedItems in
            self?.data.accept(feedItems ?? [PresentableFeedItem]())
        
            }, onError: { error in
               print("Error: Display error to UI.")

        }).disposed(by: disposeBag)
    }
    
    //MARK: PostsListViewModelProtocol
    
    func getSourceData() -> Observable<[PresentableFeedItem]> {
        return self.data.asObservable()
    }
}
