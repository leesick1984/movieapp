import Foundation

protocol DetailManagerDelegate {
    func didParsedData(_ movieData : MovieDetail?)
    func didFailWithError(error: Error)
}


class DetailDataManager {
    
    var delegate : DetailManagerDelegate?

    func fetchData(id : Int) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=ff492e9a28c2c8dacdadf2b667dbef6e"
        performRequest(with: urlString)
    }
    func performRequest(with urlString : String) {
        if let url = URL(string: urlString) {
        
        let session = URLSession(configuration: .default)
        
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    if let movie  = self.parseJson(safeData) {
                        self.delegate?.didParsedData(movie)
                    }
                }
            }
        
        task.resume()
        }
        
    }
    
    func parseJson(_ movieData : Data) -> MovieDetail? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieDetail.self, from: movieData)
            let movie : MovieDetail = decodedData
            return movie
        } catch {
            return nil
        }
    }
    

}
