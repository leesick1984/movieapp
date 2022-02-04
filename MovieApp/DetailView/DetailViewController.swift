import UIKit
import Combine

class DetailViewController: UIViewController {
    
    @IBOutlet weak var moviewImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    @IBOutlet weak var ratingBar: UIProgressView!
    
    private var viewModel: DefaultMovieListViewModel = DefaultMovieListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    
    var id : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.updateList(for: id)
        
    }
    
    private func setupBindings() {
        viewModel.movieDetail
            .receive(on: DispatchQueue.main)
            .sink {data in
                if let safeData = data {
                    self.updateUI(with: safeData )
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with movieDetail: MovieDetail) {
        
        self.movieTitle.text = movieDetail.title
        self.movieDesc.text = movieDetail.overview
        self.ratingBar.setProgress(movieDetail.getFormattedRating(), animated: false)
        
        if let imageData = viewModel.getImage(from: movieDetail) {
            self.moviewImage.image  = UIImage(data: imageData)
        }
        
    }
    
}
