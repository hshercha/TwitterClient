//
//  MenuViewController.swift
//  Twitter
//
//  Created by hsherchan on 10/7/17.
//  Copyright © 2017 Hearsay. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var profileNavigationController: UIViewController!
    private var homeNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        homeNavigationController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController")
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        viewControllers.append(profileNavigationController)
        viewControllers.append(homeNavigationController)
        viewControllers.append(mentionsNavigationController)
            
        hamburgerViewController.contentViewController = profileNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let titles = ["Profile", "Home", "Mentions"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }
}
