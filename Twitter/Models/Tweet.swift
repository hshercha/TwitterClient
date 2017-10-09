//
//  Tweet.swift
//  Twitter
//
//  Created by hsherchan on 9/30/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var commentsCount: Int = 0
    var profileImageUrl: String?
    var name: String?
    var screenName: String?
    var retweetUserName: String?
    var userId: Int?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        commentsCount = 0
        let timestampString = dictionary["created_at"] as? String
        
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        var user = dictionary["user"] as? NSDictionary
        
        let retweetedStatus = dictionary["retweeted_status"] as? NSDictionary
        if let retweetedStatus = retweetedStatus {
            retweetUserName = user!["name"] as? String
            user = retweetedStatus["user"] as? NSDictionary
            text = retweetedStatus["text"] as? String
            retweetCount = (retweetedStatus["retweet_count"] as? Int) ?? 0
            favoritesCount = (retweetedStatus["favorite_count"] as? Int) ?? 0
        }
        name = user!["name"] as? String
        screenName = user!["screen_name"] as? String
        profileImageUrl = user!["profile_image_url_https"] as? String
        userId = user!["id"] as? Int
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
