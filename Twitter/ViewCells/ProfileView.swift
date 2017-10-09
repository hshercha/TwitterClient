//
//  ProfileView.swift
//  Twitter
//
//  Created by hsherchan on 10/8/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var profile: Profile! {
        didSet {
            if profile.profileImageUrl != nil {
                profileImageView.setImageWith(profile.profileImageUrl!)
            }
            if profile.profileBannerUrl != nil {
                backgroundImageView.setImageWith(profile.profileBannerUrl!)
            }
            
            usernameLabel.text = profile.name!
            userHandleLabel.text = "@\(profile.screenname!)"
            tweetsCountLabel.text = "\(profile.totalTweets!)"
            followingCountLabel.text = "\(profile.totalFollowing!)"
            followersCountLabel.text = "\(profile.totalFollowers!)"
            
            
        }
    }
    
    

}
