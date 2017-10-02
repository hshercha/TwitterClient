//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var retweetedImageView: UIImageView!
    @IBOutlet weak var retweetedLabel: UILabel!
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userhandleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
        // Do any additional setup after loading the view.
    }

    func setupDisplay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY hh:mm a"
        timestampLabel.text = formatter.string(from: tweet.timestamp!)
        tweetLabel.text = tweet.text
        userhandleLabel.text = "@\(tweet.screenName!)"
        usernameLabel.text = tweet.name
        
        if tweet.profileImageUrl != nil {
            profileImageView.setImageWith(URL(string: tweet.profileImageUrl!)!)
        }
        
        let retweetName = tweet.retweetUserName
        
        if let retweetName = retweetName {
            retweetedLabel.text = "\(retweetName) retweeted"
            retweetedLabel.isHidden = false
            retweetedImageView.isHidden = false
        } else {
            retweetedLabel.isHidden = true
            retweetedImageView.isHidden = true
        }
        let retweetCount = tweet.retweetCount
        let favoriteCount = tweet.favoritesCount
        retweetCountLabel.text = "\(retweetCount)"
        favoriteCountLabel.text = "\(favoriteCount)"
        
        tweetLabel.sizeToFit()
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
