
import XCTest
@testable import RxSwift_MVVM
import RxSwift

class PostsListViewControllerTesta: XCTestCase {
    func test_emtyList_withEmtpyData() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func test_oneItem_withOneItemData() {
        XCTAssertEqual(makeSUT(data: [PresentableFeedItem(caption: "caption", mediaUrl: "http:mockURL.com", comments: 0, likes: 0)], selectionHandler: nil).collectionView.numberOfItems(inSection: 0), 1)
    }
    
    //MARK: Helpers
    
    func makeSUT(data: [PresentableFeedItem] = [], selectionHandler: ((PresentableFeedItem) -> Void)? = nil) -> PostsListViewController {
        let sut = PostsListViewController(viewModel: MockedViewModel(data: data)) { selectedModel in
            selectionHandler?(selectedModel)
        }
        _ = sut.view
        
        return sut
    }
}


//MARK: Mocked Classes

final class MockedViewModel: PostsListViewModelProtocol {
    private let data: [PresentableFeedItem]
    init(data: [PresentableFeedItem] = []) {
        self.data = data
    }
    func getSourceData() -> Observable<[PresentableFeedItem]> {
        return Observable.just(data)
    }
    
    
}
