//
//  TweetViewCell.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    var tweet: Tweet! {
        didSet {
            timeLabel.text = Utils.timeAgoSinceDate(date: tweet.timestamp!)
            tweetLabel.text = tweet.text
            userhandleLabel.text = "@\(tweet.screenName!)"
            usernameLabel.text = tweet.name
            
            if tweet.profileImageUrl != nil {
                profilePicImageView.setImageWith(URL(string: tweet.profileImageUrl!)!)
            }
            
            let retweetName = tweet.retweetUserName
            
            if let retweetName = retweetName {
                retweetLabel.text = "\(retweetName) retweeted"
                retweetLabel.isHidden = false
                retweetImageView.isHidden = false
            } else {
                retweetLabel.isHidden = true
                retweetImageView.isHidden = true
            }
            let retweetCount = tweet.retweetCount
            let favoriteCount = tweet.favoritesCount
            let commentCount = tweet.commentsCount
            if retweetCount != 0 {
                retweetCountLabel.isHidden = false
                retweetCountLabel.text = "\(retweetCount)"
            } else {
                retweetCountLabel.isHidden = true
            }
            
            if favoriteCount != 0 {
                favoritesCountLabel.isHidden = false
                favoritesCountLabel.text = "\(favoriteCount)"
            } else {
                favoritesCountLabel.isHidden = true
            }
            
            if commentCount != 0 {
                commentCountLabel.isHidden = false
                commentCountLabel.text = "\(commentCount)"
            } else {
                commentCountLabel.isHidden = true
            }
            
            
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicImageView.layer.cornerRadius = 30
        profilePicImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
