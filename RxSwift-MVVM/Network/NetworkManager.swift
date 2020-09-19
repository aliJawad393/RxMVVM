
import Foundation
import  RxSwift

final class NetworkManager: NetworkManagerProtocol {
    private let parser: ParserProtocol
    
    init(parser: ParserProtocol) {
        self.parser = parser
    }
    
    func fetchData<T>() -> Observable<T?> where T : Codable {
        let fileContents = readJSONFile()
        
        guard let data: Data = fileContents?.data(using: .utf8) else {
            print("Data failed to parse into Model")
            return Observable.just(nil)
        }

        
        let parsedData = parser.parseResponse(data: data, response: PostsListResponse.self)
        return Observable.just(parsedData as? T)
    }
    
    //MARK: File Reading
    
    private func readJSONFile() -> String? {
       let bundle = Bundle.main
        let path = bundle.path(forResource: "sampleJson", ofType: "txt")
        
        if let path = path {
            return try? String(contentsOfFile: path)
        }
        
        return nil
    }
}
