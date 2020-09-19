
import Foundation
import UIKit
import RxSwift
import RxCocoa

final class PostsListViewController: UIViewController {
    private let viewModel: PostsListViewModelProtocol
    private let disposeBag = DisposeBag()
    private var selectionHandler: (PresentableFeedItem) -> Void
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Init
    
    init(viewModel: PostsListViewModelProtocol, selectionHandler: @escaping (PresentableFeedItem) -> Void) {
        self.viewModel = viewModel
        self.selectionHandler = selectionHandler
        super.init(nibName: "PostsListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        self.collectionView.register(PostListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.register(UINib(nibName: "PostListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.title = "Posts"
        self.bindUI()
    }
}

//MARK: Private Methods
extension PostsListViewController {
    
    private func bindUI() {
     
        viewModel.getSourceData().bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: PostListCollectionViewCell.self)) { row, data, cell in
            cell.imageView.sd_setImage(with: URL(string: data.mediaUrl), placeholderImage: UIImage(named: "no-image-icon"), options: .lowPriority, context: nil)
        }.disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(PresentableFeedItem.self)
        .subscribe(onNext: {[weak self] model in
            self?.selectionHandler(model)
            
        }).disposed(by: disposeBag)
        
    }
}
