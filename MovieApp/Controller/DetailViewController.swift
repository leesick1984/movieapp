import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var moviewImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    var id : Int = 0
    
    let detailManager = DetailDataManager()
    var movieData : MovieDetail? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        detailManager.delegate = self
        detailManager.fetchData(id: id)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Delegates

extension DetailViewController : DetailManagerDelegate {
    func didParsedData(_ movieData: MovieDetail?) {
        DispatchQueue.main.async {
            if let safeData = movieData {
                self.movieTitle.text = safeData.title
                self.movieDesc.text = safeData.overview
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
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
