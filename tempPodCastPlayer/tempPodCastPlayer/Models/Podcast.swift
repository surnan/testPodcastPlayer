//
//  Podcast.swift
//  tempPodCastPlayer
//
//  Created by admin on 1/8/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

struct Podcast: Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feeduRL: String?
}

/*  Decodable Protocol needed because this struct is a member of: 'SearchResults:Decodable' in PodcastsSearchController
Because this struct is receiving values from JSON, we need to make sure the variable names match, the left entry in JSON files.
 
 JSONDecoder().decode(SearchResults.self, from: data)  //  .SELF
 "trackName": "Better Together",  <--- line from JSON
 */

