//
//  PhotoItemView.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import Foundation
import SwiftUI
import UIKit

struct PhotoItemView: View {
    var photoItem: PhotoItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: photoItem.media.m)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300, alignment: .bottom)
                }
                placeholder: {
                    Image(systemName: "photo.fill")
                        .accessibilityLabel("place holder image")
                }
                Text(photoItem.description.getImgSizeString())
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.red, lineWidth: 4)
                    )
                Text(photoItem.title)
                WebText(html: photoItem.description)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.blue, lineWidth: 4)
                    )
                Text(photoItem.author)
                Text(photoItem.published.displayDate())
            }
        }
    }
}
