//
//  TweetsViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import MBProgressHUD
import UIKit

class TweetsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var selectedTweet: Tweet?
    var timeline: TweetTimeline?
    var timelineStr: String!
    var parameters: NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let timeline = timeline {
            timelineStr = timeline.rawValue
        } else {
            timelineStr = TweetTimeline.home.rawValue
        }
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
        loadTweets(refreshControl: refreshControl)
    }
    
    func loadTweets(refreshControl: UIRefreshControl?){
        MBProgressHUD.showAdded(to: self.tableView, animated: true)
        TwitterClient.sharedInstance?.timeline(timelineType: timelineStr, parameters: parameters, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.tableView, animated: true)
            if let refresh = refreshControl as UIRefreshControl? {
                refresh.endRefreshing()
            }
        }, failure: { (error: Error) in
            MBProgressHUD.hide(for: self.tableView, animated: true)
            if let refresh = refreshControl as UIRefreshControl? {
                refresh.endRefreshing()
            }
            print (error.localizedDescription)
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
        cell.delegate = self
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

extension TweetsViewController: TweetCellDelegate {
    func selectProfile(selectCell: TweetViewCell) {
        let indexPath = tableView.indexPath(for: selectCell)!
        let tweet = tweets![indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.userId = tweet.userId
        profileViewController.screenName = tweet.screenName
        profileViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBack(_:)))
        profileViewController.navigationItem.leftBarButtonItem?.tintColor = .white
        let navController = UINavigationController(rootViewController: profileViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func goBack(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
}


