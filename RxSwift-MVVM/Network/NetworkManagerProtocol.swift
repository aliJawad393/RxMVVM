
import Foundation
import RxSwift

public protocol NetworkManagerProtocol {
    func fetchData<T: Codable>() -> Observable<T?>
    
}
