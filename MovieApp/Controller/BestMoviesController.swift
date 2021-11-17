import Foundation
import UIKit

class BestMoviesController : UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.getBestMovieList(for: 1)
        titleLable.text = "Loaded"
    }
}

extension BestMoviesController : DataManagerDelegate {
    func didParsedData<T>(_ movieData: T) where T : Decodable {
        
    }
    
    func didFailWithError(error: Error) {
    
    }
    
    
}
