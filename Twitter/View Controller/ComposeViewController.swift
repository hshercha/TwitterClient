//
//  ComposeViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/1/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

@objc protocol ComposeViewControllerDelegate {
    @objc optional func composeViewController(composeViewController: ComposeViewController, tweet: Tweet?)
}

class ComposeViewController: UIViewController {
    weak var delegate: ComposeViewControllerDelegate?
    @IBOutlet weak var usernameHandleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var tweetBtn: UIBarButtonItem!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = User.currentUser?.name
        usernameHandleLabel.text = User.currentUser?.screenname
        profileImageView.setImageWith((User.currentUser?.profileUrl)!)
        
        tweetTextView.layer.cornerRadius = 5
        tweetTextView.layer.borderColor = UIColor(red: 29.0/255, green: 202.0/255, blue: 255.0/255, alpha: 1.0).cgColor
        tweetTextView.layer.borderWidth = 1
        
        tweetTextView.text = "What's happening?"
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.delegate = self
        characterCountLabel.text = "140"
        tweetBtn.isEnabled = false
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 
    @IBAction func onTweetButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        TwitterClient.sharedInstance?.postNewTweet(tweet: tweetTextView.text, success: { (tweet: Tweet) -> () in
            (self.delegate?.composeViewController!(composeViewController: self, tweet: tweet))
        }, failure: { (error: Error) in
            print (error.localizedDescription)
        })
        
    }
    
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
            tweetBtn.isEnabled = false
        } else {
            tweetBtn.isEnabled = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if (textView.text.isEmpty) {
            tweetBtn.isEnabled = false
        } else {
            tweetBtn.isEnabled = true
        }
        characterCountLabel.text = "\(140 - textView.text.characters.count)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= 140
    }
}
