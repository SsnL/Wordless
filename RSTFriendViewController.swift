//
//  RSTFriendViewController.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
import UIKit

class RSTFriendViewController: UITableViewController {
    
    var objects = NSMutableArray.array()

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init(fbFriends: NSArray) {
        super.init(style: UITableViewStyle.Plain)
        self.objects = fbFriends.mutableCopy() as NSMutableArray
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()

//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//
//    func insertNewObject(sender: AnyObject) {
//        var newWordField: UITextField?
//        func wordEntered(alert: UIAlertAction!) {
//            let str = newWordField!.text
//            if (str.isEmpty) {
//                return;
//            }
//            objects.insertObject(Person(name: newWordField!.text), atIndex: 0)
//            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        }
//
//        // display an alert
//        let newWordPrompt = UIAlertController(title: "Enter contact name", message: "Chat wordlessly!", preferredStyle: UIAlertControllerStyle.Alert)
//        newWordPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
//            textField.placeholder = "Name"
//            textField.secureTextEntry = false
//            newWordField = textField
//        })
//        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: wordEntered))
//        presentViewController(newWordPrompt, animated: true, completion: nil)
//    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let object = self.objects[indexPath.row]
        cell.textLabel?.text = (object as FBGraphObject).objectForKey("name") as String

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = DetailViewController()
        vc.receiver = (objects.objectAtIndex(indexPath.row) as FBGraphObject).objectForKey("id") as String
        self.navigationController!.pushViewController(vc, animated: true)
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
