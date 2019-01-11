//
//  APIService.swift
//  tempPodCastPlayer
//
//  Created by admin on 1/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) ->()){
        print("Searching for podcasts....")
        
        //        let url = "https://itunes.apple.com/search?term=\(searchText)"  //googled itunes API to get format
        //        //Below will not make the %20 substituion for space
        //        Alamofire.request(url).responseData { (dataResponse) in
        //            if let err = dataResponse.error {
        //                print("Failed to contact itunes \(err)")
        //            }
        //        Alamofire.request(url2, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil){
        
        let url2 = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]  //parameter options specified on iTunes API page
        
        
        Alamofire.request(url2, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            guard let data = dataResponse.data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)  //  .SELF
                searchResult.results.forEach{print($0.artistName ?? "", $0.trackName ?? "")}

                completionHandler(searchResult.results)
                
                /*
                self.podcasts = searchResult.results  //re-populating the tableView Array
                self.tableView.reloadData()
                 */

            } catch let err {
                print("Unable to decode JSON data pulled from iTunes API to SearchResults struct \(err)")
            }
        }
    }
    
    struct SearchResults: Decodable { //data pulled from iTunes API
        let resultCount: Int
        let results: [Podcast]
    }
}
