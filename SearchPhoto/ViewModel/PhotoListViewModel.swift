//
//  PhotoListViewModel.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import Foundation

class PhotoListViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var photoList = PhotoList()
    @Published var showProgress = false
    @Published var showErrorMsg = false
    
    var service = DataService()
   
    func fetchData() {
        let query = searchText
        let urlStr = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=" + query
        guard let url = URL(string: urlStr) else { return }
        showProgress = true
        service.fetchPhotos(url: url) {[weak self] (response: Result<PhotoList, NetworkError>) in
            self?.showProgress = false
            switch response{
                case .success(let photos):
                    self?.photoList = photos
                    print(photos)
                case .failure(_):
                    self?.showErrorMsg = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.showErrorMsg = false
                    }
                    print()
            }
        }
    }
}
