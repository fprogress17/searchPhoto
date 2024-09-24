//
//  String+.swift
//  SearchPhoto
//
//  Created by Choonghun Lee on 9/23/24.
//

import Foundation

extension String {
    func displayDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE, MMM dd, yyyy"
            let formattedDateString = outputFormatter.string(from: date)
            return formattedDateString
        } else {
            return "--"
        }
    }
}

extension String {
    func getImgSize() -> (String, String) {
        let res = self.components(separatedBy: " ")
        let widths = res.filter {$0.contains("width=")}
        var width: String?
        var height: String?
        
        if let firstWidth = widths.first {
            width = firstWidth.replacingOccurrences(of: #"\"#, with: "", options: .literal, range: nil)
            width = width?.replacingOccurrences(of: "width=", with: "", options: .literal, range: nil)
        }
        let heights = res.filter {$0.contains("height=")}
        if let firstHeight = heights.first {
            height = firstHeight.replacingOccurrences(of: #"\"#, with: "", options: .literal, range: nil)
            height = height?.replacingOccurrences(of: "height=", with: "", options: .literal, range: nil)
        }
        
        return (width ?? "-", height ?? "-")
    }
    
    func getImgSizeString() -> String {
        let size = getImgSize()
        return "Width: " + size.0 + " " + "Height: " + size.1
    }
}
