
import Foundation
import RxSwift

public protocol DatabaseManagerProtocol {
    func fetchData<T>() -> [T]?
    func saveData<D>(data: D)
}
