import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var moviewImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var ratingBar: UIProgressView!

    var id : Int = 0
    
    let dataManager = DataManager()
    var movieData : MovieDetail? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.getMovieDetail(id: id)
    }
    
}

//MARK: - Delegate

extension DetailViewController : DataManagerDelegate {
    func didParsedData<T>(_ movieData: T) where T : Decodable {

        DispatchQueue.main.async {
             let safeData = movieData as! MovieDetail
                self.movieTitle.text = safeData.title
                self.movieDesc.text = safeData.overview
                
                
                self.ratingBar.setProgress(safeData.getFormattedRating(), animated: false)
                do {
                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(safeData.backdrop_path)")
                    let data = try Data(contentsOf: url!)
                    self.moviewImage.image  = UIImage(data: data)
                }
                catch{
                    print(error)
                }
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
