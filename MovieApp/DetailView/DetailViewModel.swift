//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Alexander Lee on 02.02.2022.
//

import Foundation
import Combine

protocol DetailViewModel: ObservableObject {
    func updateList(for id: Int)
}

final class DefaultMovieListViewModel: DetailViewModel {
    
    
    var movieDetail = CurrentValueSubject<MovieDetail?, Never>(nil)
    
    func updateList(for id: Int) {
        
        let urlString = "\(ApiLinks.detailMovie.rawValue)/\(id)?api_key=\(MovieApi.shared.apiKey)"
        MovieApi.shared.performAPICall(url: urlString, expectingReturnType: MovieDetail.self, completion: {result in
            switch result {
            case .success(let list):
                self.movieDetail.value = list
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func getImage(from movieDetail: MovieDetail) -> Data? {
        do {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetail.backdrop_path)")
            let data = try Data(contentsOf: url!)
            return data
        }
        catch {
            print(error)
        }
        return nil
    }
    
}


