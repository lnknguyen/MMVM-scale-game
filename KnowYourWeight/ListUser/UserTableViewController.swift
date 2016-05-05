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
    
    //MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Route.FROM_USERLIST_TO_HOME{
            let tabBarVc = segue.destinationViewController as! UITabBarController
            let destinationVc1 = tabBarVc.viewControllers![0] as! HomeViewController
            let destinationVc2 = tabBarVc.viewControllers![1] as! GraphViewController
            
            let index = self.tableView.indexPathForSelectedRow?.row
            let user = viewModel.users![index!]
            
            let homeViewModel = HomeViewModel()
            let graphViewModel = GraphViewModel()
            homeViewModel.user = user
            graphViewModel.user = user
            
            destinationVc1.viewModel = homeViewModel
            destinationVc2.viewModel = graphViewModel
            
            
        }
    }
    
    
    @IBAction func unwindToUserList(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func cancelToUserList(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func finishSignup(segue: UIStoryboardSegue){
        
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
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = users![indexPath.row]
        
        let destinationVc = HomeViewController();
        
        destinationVc.user = user;
        
        destinationVc.performSegueWithIdentifier("fromUserListToHome", sender: self)
        
    }
     */
    

}
