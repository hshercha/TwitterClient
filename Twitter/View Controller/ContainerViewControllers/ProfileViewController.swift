//
//  ProfileViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/8/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class ProfileViewController: TweetsViewController {
    var userId:Int?
    var screenName:String?
    
    @IBOutlet weak var profileView: ProfileView!
    override func viewDidLoad() {
        timeline = TweetTimeline.user
        profileView.profileImageView.layer.cornerRadius = 35
        profileView.profileImageView.clipsToBounds = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateParameters()
        TwitterClient.sharedInstance?.currentProfile(parameters: parameters, success: { (profile: Profile) in
            self.profileView.profile = profile
            
        }, failure: { (error: Error) in
            print("error")
        })
        loadTweets(refreshControl: nil)
    }
    
    func updateParameters() {
        if let curUserId = userId {
            parameters = ["user_id": curUserId, "screen_name": screenName]
        } else {
            parameters = ["user_id": User.currentUser?.userId, "screen_name": User.currentUser?.screenname]
        }
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
