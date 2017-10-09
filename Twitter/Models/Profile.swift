//
//  Profile.swift
//  Twitter
//
//  Created by hsherchan on 10/8/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class Profile: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl:URL?
    var profileBannerUrl:URL?
    var tagline:String?
    var totalFollowing:Int?
    var totalFollowers:Int?
    var totalTweets:Int?
    
    var dictionary: NSDictionary
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        print(dictionary)
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        
        if let profileUrlString = profileUrlString {
            profileImageUrl = URL(string: profileUrlString)
        }
        
        let profileBannerUrlString = dictionary["profile_background_image_url_https"] as? String
        
        if let profileBannerUrlString = profileBannerUrlString {
            profileBannerUrl = URL(string: profileBannerUrlString)
        }
        
        totalFollowing = dictionary["friends_count"] as? Int
        totalFollowers = dictionary["followers_count"] as? Int
        totalTweets = dictionary["statuses_count"] as? Int
        
        tagline = dictionary["description"] as? String
    }

}
