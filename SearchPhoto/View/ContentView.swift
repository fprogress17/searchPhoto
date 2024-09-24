//
//  ContentView.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    typealias ViewModel = PhotoListViewModel
    @ObservedObject var viewModel = PhotoListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.showProgress {
                    ProgressView()
                }
                if viewModel.showErrorMsg {
                    Text(viewModel.errorMsg)
                }
                List {
                    ForEach(viewModel.photoList.items,  id: \.id) { item in
                        VStack(alignment: .leading) {
                            NavigationLink(value: item) {
                                AsyncImage(url: URL(string: item.media.m)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                            placeholder: {
                                Image(systemName: "photo.fill")
                                    .accessibilityLabel("place holder image")
                            }
                            }
                        }
                    }
                }
                .navigationDestination(for: PhotoItem.self) { photoItem in
                    PhotoItemView(photoItem: photoItem)
                }
                .navigationTitle("Photos")
            }
        }
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search, viewModel.fetchData)
    }
}

