//
//  MasterViewController.swift
//  Wordless
//
//  Created by S_sn on 10/3/14.
//  Copyright (c) 2014 RST. All rights reserved.
//

import UIKit

struct FbUser {
    static var user: RSTUser!
}

class MasterViewController: UITableViewController, FBLoginViewDelegate, PFLogInViewControllerDelegate {

    var objects = NSMutableArray()
    var fbFriends: NSArray! = NSArray.array()

    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        NSLog("Login Error")
    }

    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        FbUser.user = RSTUser(name: user.name, id: user.objectForKey("id") as String!)
        //FbUser.user.saveInBackground()
    }

    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        var friendsRequest = FBRequest.requestForMyFriends()
        friendsRequest.startWithCompletionHandler{(connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
            var resultdict : NSDictionary = result as NSDictionary
            NSLog("%@", resultdict)
            var data : NSArray = resultdict.objectForKey("data") as NSArray

            for i in 0..<data.count {
                let valueDict : NSDictionary = data[i] as NSDictionary
                let id = valueDict.objectForKey("id") as String
            }

            self.fbFriends = resultdict.objectForKey("data") as NSArray
            let vc = RSTFriendViewController(fbFriends: self.fbFriends)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton

        let fbLoginView = FBLoginView(readPermissions: ["public_profile", "email", "user_friends"])
        fbLoginView.delegate = self
        fbLoginView.center = self.view.center
        self.view.addSubview(fbLoginView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        var newWordField: UITextField?
        func wordEntered(alert: UIAlertAction!) {
            let str = newWordField!.text
            if (str.isEmpty) {
                return;
            }
            objects.insertObject(Person(name: newWordField!.text), atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }

        // display an alert
        let newWordPrompt = UIAlertController(title: "Enter contact name", message: "Chat wordlessly!", preferredStyle: UIAlertControllerStyle.Alert)
        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Name"
            textField.secureTextEntry = false
            newWordField = textField
        })
        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: wordEntered))
        presentViewController(newWordPrompt, animated: true, completion: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as Person
                NSLog("nothing")
//            (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row] as Person
        cell.textLabel?.text = object.name
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

