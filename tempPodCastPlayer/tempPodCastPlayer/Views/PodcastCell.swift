//
//  PodcastCell.swift
//  tempPodCastPlayer
//
//  Created by admin on 1/11/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            print("loading image with URL = \(podcast.artworkUrl600 ?? "")")
//            guard let url = URL(string: podcast.artworkUrl600 ?? "") else {return} //Very slick.  Plugs in blank string which will auto-fail.  To avoid double-Lets
             guard  let artworkURL = podcast.artworkUrl600, let url = URL(string: artworkURL) else {return}
            
            
            /*
            //Below works but has no image caching.  Scrolling rows off-screen pops them from memory
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.podcastImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
            */
            
            //Below it cached images from SDWebImage-CocaoPod
            podcastImageView.sd_setImage(with: url, completed: nil)
            
            
        }
    }
}
