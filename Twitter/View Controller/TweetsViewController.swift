//
//  TweetsViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var selectedTweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
     TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print (error.localizedDescription)
        })
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at:0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func onComposeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {
            let navigationController = segue.destination as! UINavigationController
            let composeViewController = navigationController.topViewController as! ComposeViewController
            composeViewController.delegate = self
        } else if segue.identifier == "detailsSegue" {
            let detailsViewController = segue.destination as! TweetDetailsViewController
            detailsViewController.tweet = selectedTweet
        }
    }
    
    func loadMoreTweets(refreshControl: UIRefreshControl?) {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            if let refresh = refreshControl as UIRefreshControl? {
                refresh.endRefreshing()
            }
        }, failure: { (error: Error) in
            if let refresh = refreshControl as UIRefreshControl? {
                refresh.endRefreshing()
            }
        })
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadMoreTweets(refreshControl: refreshControl)
    }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetViewCell
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTweet = tweets![indexPath.row]
        self.performSegue(withIdentifier: "detailsSegue", sender: nil)
        
    }
}

extension TweetsViewController: ComposeViewControllerDelegate {
    func composeViewController(composeViewController: ComposeViewController, tweet: Tweet?) {
        tweets?.insert(tweet!, at: 0)
        self.tableView.reloadData()
    }
}
