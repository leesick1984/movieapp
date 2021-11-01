struct MovieData : Decodable {
    let results : [Movie]
}
struct Movie : Decodable {
    let title : String
    let poster_path : String
}
