//
//  UserTableViewController.swift
//  KnowYourWeight
//
//  Created by Nguyen Luong on 5/1/16.
//  Copyright © 2016 Nguyen Luong. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {

    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(UserTableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        self.tableView.separatorColor = UIColor.clearColor()
        Utility.setTableViewBackgroundGradient(self, UIColor.darkGrayColor(), UIColor.brownColor())
        
        Utility.getCurrentDate()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        bindViewModel()
    }
    
    func refresh(){
        bindViewModel{
            self.refreshControl?.endRefreshing()
        }
    }
    
    private func bindViewModel(completionHandler:()->Void = {}){
        
        viewModel.reloadAllUser(){
             self.tableView.reloadData()
        }
        
        completionHandler()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.users!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath)

        let user = viewModel.users![indexPath.row]
        cell.textLabel?.text = user.name.value
        cell.detailTextLabel?.text = ""
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = viewModel.users![indexPath.row]
        
        let destinationVc = HomeViewController();
        
        destinationVc.viewModel.user = user;
        
        destinationVc.performSegueWithIdentifier(Route.FROM_USER_LIST_TO_USER_DETAIL, sender: self)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Route.FROM_USER_LIST_TO_USER_DETAIL{
           // let tabBarVc = segue.destinationViewController as! UITabBarController
            let destionationVc = HomeViewController()
            
            let index = self.tableView.indexPathForSelectedRow?.row
            let user = viewModel.users![index!]
            
            print(destionationVc)
            destionationVc.viewModel.user = user
            
            
        }
    }

    

}
