//
//  HomeViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/8/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class HomeViewController: TweetsViewController {

    override func viewDidLoad() {
        timeline = TweetTimeline.home
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTweets(refreshControl: nil)
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
