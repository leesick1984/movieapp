import Foundation
import Combine

class MovieApi {
    
    static let shared = MovieApi()
    let apiKey = "ff492e9a28c2c8dacdadf2b667dbef6e"
    var delegate : DataManagerDelegate?
    
    public func performAPICall<T: Codable>(url: String, expectingReturnType: T.Type, completion: @escaping((Result<T, Error>) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, _,  error in
            guard let data = data, error == nil else {
                return
            }
            
            var decodedResult : T?
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
            } catch {
                decodedResult = nil
                print(error)
            }
            
            guard let result = decodedResult else {
                return
            }
            
            completion(.success(result))
        })
        
        task.resume()
    }
    
    public func requestData(for urlString: URL) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: urlString)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
