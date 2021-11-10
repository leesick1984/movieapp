import Foundation

protocol DataManagerDelegate {
    func didParsedData<T : Decodable>(_ movieData : T)
    func didFailWithError(error: Error)
}


class DataManager {
    
    var delegate : DataManagerDelegate?
    
    func getMovieList(for page: Int) {
        let urlString = "\(ApiLinks.nowPlaying.rawValue)?api_key=\(MovieApi.shared.apiKey)&page=\(page)"
        MovieApi.shared.performAPICall(url: urlString, expectingReturnType: MovieData.self, completion: {result in
            switch result {
            case .success(let list):
                let movieList : [MovieList] = list.results
                self.delegate?.didParsedData(movieList)
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getMovieDetail(id: Int) {
        let urlString = "\(ApiLinks.detailMovie.rawValue)/movie/\(id)?api_key=\(MovieApi.shared.apiKey)"
        MovieApi.shared.performAPICall(url: urlString, expectingReturnType: MovieDetail.self, completion: {result in
            switch result {
            case .success(let list):
                let movieList : MovieDetail = list
                self.delegate?.didParsedData(movieList)
                
            case .failure(let error):
                print(error)
            }
        })
    }
}


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
    
    
}
