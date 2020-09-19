
import Foundation
import UIKit
import SDWebImage

final class PostDetailViewController: UIViewController {
    private let data: PresentableFeedItem
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelCaption: UILabel!
    @IBOutlet weak var labelCommentsAndLikes: UILabel!
    
    
    init(data: PresentableFeedItem) {
        self.data = data
        super.init(nibName: "PostDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildUI()
        labelCommentsAndLikes.text = "\(data.likes) Likes   \(data.comments) Comments"
    }
    
    //MARK: Private
    
    private func buildUI() {
        labelCaption.text = data.caption
        imageView.sd_setImage(with: URL(string: data.mediaUrl), completed: nil)
    }
}
