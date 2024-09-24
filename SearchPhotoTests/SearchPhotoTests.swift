//
//  SearchPhotoTests.swift
//  SearchPhotoTests
//
//  Created by Choonghun Lee on 9/23/24.
//

import XCTest
@testable import SearchPhoto

final class SearchPhotoTests: XCTestCase {
    // Test for valid date string
   func testValidDate() {
       let validDateString = "2024-09-23T08:51:26Z"
       let expectedOutput = "Monday, Sep 23, 2024"
       XCTAssertEqual(validDateString.displayDate(), expectedOutput, "error for valid date string.")
   }
   
   // Test for invalid date string
   func testInvalidDate() {
       let invalidDateString = "invalid-date-string"
       let expectedOutput = "--"
       XCTAssertEqual(invalidDateString.displayDate(), expectedOutput, "error for an invalid date string.")
   }
   
   // Test for empty string
   func testEmptyString() {
       let emptyString = ""
       let expectedOutput = "--"
       XCTAssertEqual(emptyString.displayDate(), expectedOutput, "error for an empty date string.")
   }
   
   // Test for edge case - Different format but valid date
   func testDifferentFormat() {
       let differentFormatDateString = "2024-09-23"
       let expectedOutput = "--"
       XCTAssertEqual(differentFormatDateString.displayDate(), expectedOutput, "error input format.")
   }
    

        // Sample JSON for testing
        let JSON = """
        {
            "title": "Recent Uploads tagged forest, bird and rain",
            "link": "https://www.flickr.com/photos/",
            "description": "",
            "modified": "2024-08-20T23:32:03Z",
            "generator": "https://www.flickr.com",
            "items": [
                {
                    "title": "Black Day, Black Face",
                    "link": "https://www.flickr.com/photos/21147276@N03/53937240990/",
                    "media": {"m":"https://live.staticflickr.com/65535/53937240990_c19ff78e53_m.jpg"},
                    "date_taken": "2024-08-20T18:30:53-08:00",
                    "description": "A photo description",
                    "published": "2024-08-20T23:32:03Z",
                    "author": "nobody@flickr.com",
                    "author_id": "21147276@N03",
                    "tags": "forest bird rain"
                }
            ]
        }
        """.data(using: .utf8)!
    
    func testPhotoListDecoding() {
          let decoder = JSONDecoder()

          do {
              // Try to decode the JSON into PhotoList
              let photoList = try decoder.decode(PhotoList.self, from: JSON)

              // Assert that the title is correct
              XCTAssertEqual(photoList.title, "Recent Uploads tagged forest, bird and rain")
              
              // Assert that the link is correct
              XCTAssertEqual(photoList.link, "https://www.flickr.com/photos/")
              
              // Assert that the modified date is correct
              XCTAssertEqual(photoList.modified, "2024-08-20T23:32:03Z")
              
              // Assert that items array has one PhotoItem
              XCTAssertEqual(photoList.items.count, 1)
              
              // Assert the values of the first PhotoItem
              let firstItem = photoList.items[0]
              XCTAssertEqual(firstItem.title, "Black Day, Black Face")
              XCTAssertEqual(firstItem.link, "https://www.flickr.com/photos/21147276@N03/53937240990/")
              XCTAssertEqual(firstItem.media.m, "https://live.staticflickr.com/65535/53937240990_c19ff78e53_m.jpg")
              XCTAssertEqual(firstItem.dateTaken, "2024-08-20T18:30:53-08:00")
              XCTAssertEqual(firstItem.description, "A photo description")
              XCTAssertEqual(firstItem.published, "2024-08-20T23:32:03Z")
              XCTAssertEqual(firstItem.author, "nobody@flickr.com")
              XCTAssertEqual(firstItem.authorID, "21147276@N03")
              XCTAssertEqual(firstItem.tags, "forest bird rain")
              
          } catch {
              XCTFail("Decoding failed: \(error.localizedDescription)")
          }
      }
}
