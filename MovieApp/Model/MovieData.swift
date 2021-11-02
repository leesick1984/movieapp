struct MovieData : Decodable {
    let results : [Movie]
}
struct Movie : Decodable {
    let id : Int
    let title : String
    let poster_path : String
}
struct MovieDetail : Decodable {
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


