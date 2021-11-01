import UIKit

class NowPlayingController: UIViewController {

    @IBOutlet weak var table: UITableView!

    let dataManager = ListDataManager()
    
    
    var currentPage : Int = 1
    var movieData : [Movie] = []
    var id : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchData(pageNum: currentPage)
        dataManager.delegate = self
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }
    

}

//MARK: - Delegates

extension NowPlayingController : DataManagerDelegate {
    func didParsedData(_ movieData: [Movie]) {
        DispatchQueue.main.async {
            self.movieData.append(contentsOf: movieData)
            self.table.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - Extensions

extension NowPlayingController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if !(indexPath.row + 1 < 20*currentPage) {
            self.currentPage += 1
            dataManager.fetchData(pageNum: currentPage)
        }
        
        let movie = movieData[indexPath.row]
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell

        cell.label.text = movie.title
        cell.tag = movie.id
        cell.imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow

        let currentCell = tableView.cellForRow(at: indexPath!) as! CustomTableViewCell?
        
        let displayVC : DetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        displayVC.id = currentCell!.tag
        
        self.present(displayVC, animated: true, completion: nil)

    }
}
