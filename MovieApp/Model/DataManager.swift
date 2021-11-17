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
    
    func getBestMovieList(for page: Int) {
        let urlString = "\(ApiLinks.bestMovies.rawValue)?api_key=\(MovieApi.shared.apiKey)&page=\(page)"
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
        let urlString = "\(ApiLinks.detailMovie.rawValue)/\(id)?api_key=\(MovieApi.shared.apiKey)"
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
