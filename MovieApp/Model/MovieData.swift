struct MovieData : Codable {
    let results : [MovieList]
}
struct MovieList : Codable {
    let id : Int
    let title : String
    let poster_path : String
}
struct MovieDetail : Codable {
    let title : String
    let backdrop_path : String
    let original_title : String
    let overview : String
    let release_date : String
    let revenue : Int
    let runtime : Int
    let vote_average : Float
    
    func getFormattedRating() -> Float {
        return vote_average / 10
    }
    
}
enum ApiLinks : String {
    case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    case detailMovie = "https://api.themoviedb.org/3/movie"
}
