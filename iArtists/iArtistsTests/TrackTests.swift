//
//  TrackTests.swift
//  iArtistsTests
//
//  Created by Mike Conner on 7/9/21.
//

import XCTest
@testable import iArtists

class TrackTests: XCTestCase {
    
    var tracks      : Tracks!
    var trackOne    : Track!
    var trackTwo    : Track!
    var trackThree  : Track!
    var jsonData    : Data!
    let mockJSON    : String = """
                               {
                               "results":
                               [
                               {
                               "artistName": "John Doe",
                               "trackName": "Great song",
                               "releaseDate": "2021-07-09T21:59:20Z",
                               "primaryGenreName": "Pop",
                               "trackPrice": 1.99,
                               "artworkUrl100": "image.jpg",
                               "previewUrl": "www.rockingtriangle.com"
                               },
                               {
                               "artistName": "Jane Doe",
                               "trackName": "Better song",
                               "releaseDate": "198A-05-03A21:59:20Z",
                               "primaryGenreName": "Rock",
                               "trackPrice": -1.20,
                               "artworkUrl100": "itunesSearch",
                               "previewUrl": "com.rockingtriangle.www"
                               },
                               {
                               "artistName": null,
                               "trackName": null,
                               "releaseDate": null,
                               "primaryGenreName": null,
                               "trackPrice": null,
                               "artworkUrl100": null,
                               "previewUrl": null
                               }
                               ]
                               }
                               """
    
    override func setUpWithError() throws {
        jsonData = mockJSON.data(using: .utf8)
        tracks = try! JSONDecoder().decode(Tracks.self, from: jsonData)
        trackOne = tracks.results[0]
        trackTwo = tracks.results[1]
        trackThree = tracks.results[2]
    }

    override func tearDownWithError() throws {
        jsonData = nil
        tracks = nil
        trackOne = nil
        trackTwo = nil
        trackThree = nil
    }

    func testValidateDecodedTrackData() throws {
        // Test correct creation of tracks from mock data
        XCTAssertTrue(tracks.results.count == 3)
        XCTAssertFalse(tracks.results.count > 3)
        XCTAssertFalse(tracks.results.count < 3)
        
        // Test correctness of tracks
        XCTAssertTrue(trackOne.displayArtistName == "John Doe")
        XCTAssertTrue(trackOne.displayTrackName == "Great song")
        XCTAssertTrue(trackOne.displayPrimaryGenreName == "Pop")
        XCTAssertTrue(trackOne.displayReleaseDate == "Jul 09, 2021")
        XCTAssertTrue(trackOne.displayTrackCover == "image.jpg")
        XCTAssertTrue(trackOne.displayTrackPreview == "www.rockingtriangle.com")
        XCTAssertTrue(trackOne.displayTrackPrice == "$1.99")
        XCTAssertTrue(trackOne.sortingDate < "2021-12-31T23:59:59Z")
        
        XCTAssertTrue(trackTwo.displayReleaseDate == "N/A")
        XCTAssertTrue(trackTwo.displayTrackPrice == "N/A")
        
        XCTAssertTrue(trackThree.displayArtistName == "Not Available")
        XCTAssertTrue(trackThree.displayTrackName == "Not Available")
        XCTAssertTrue(trackThree.displayPrimaryGenreName == "N/A")
        XCTAssertTrue(trackThree.displayReleaseDate == "N/A")
        XCTAssertTrue(trackThree.displayTrackCover == "itunesSearch")
        XCTAssertTrue(trackThree.displayTrackPreview == "")
        XCTAssertTrue(trackThree.displayTrackPrice == "N/A")
        XCTAssertTrue(trackThree.sortingDate == "N/A")
    }

}
