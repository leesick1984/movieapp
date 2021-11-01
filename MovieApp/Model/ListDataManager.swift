import Foundation

protocol DataManagerDelegate {
    func didParsedData(_ movieData : [Movie])
    func didFailWithError(error: Error)
}

class ListDataManager {

    var dataUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=ff492e9a28c2c8dacdadf2b667dbef6e"

    var delegate : DataManagerDelegate?

    func fetchData(pageNum : Int) {
        let urlString = "\(dataUrl)&page=\(pageNum)"
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
    func parseJson(_ movieData : Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            let movie : [Movie] = decodedData.results

            return movie
        } catch {
            return nil
        }
    }
    

}
