//
//  PodcastsSearchController.swift
//  tempPodCastPlayer
//
//  Created by admin on 1/8/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController,  UISearchBarDelegate {
    
    let cellID = "asdfasdf"
    var podcasts = [Podcast]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    
    //MARK:- TableView
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please Enter a Search Term"
        
        label.attributedText = NSAttributedString(string: "Please Enter a Search Term", attributes: [NSAttributedString.Key.font: UIFont(name: "Papyrus", size: 25)!,NSAttributedString.Key.foregroundColor : UIColor.purple,])
        label.textAlignment = .center
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  podcasts.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PodcastCell
        
        cell.podcast = podcasts[indexPath.row]
        
        
//        let podcast = podcasts[indexPath.row]
//        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
//        cell.textLabel?.numberOfLines = -1
//        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
    }
    
    fileprivate func setupTableView() {
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()    //Get rid of row divider lines
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    //MARK:- Search Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
    }
    
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false   //greys content during search
        searchController.searchBar.delegate = self
    }
}
