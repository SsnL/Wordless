//
//  DetailViewController.swift
//  Wordless
//
//  Created by S_sn on 10/3/14.
//  Copyright (c) 2014 RST. All rights reserved.
//

import UIKit

class DetailViewController: JSQMessagesViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var receiver: String!
    
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory.outgoingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory.incomingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    
    private var messages: Array<JSQMessageData> = []
//
//
//    var detailItem: AnyObject? {
//        didSet {
////            println(detailItem!)
//            // Update the view.
////            self.configureView()
//        }
//    }
//
//    func configureView() {
//        // Update the user interface for the detail item.
//        if let detail: AnyObject = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
//    }
//
//    init(receiver r: RSTUser) {
//        receiver = r
//        super.init()
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        receiver = nil
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("loaded with receiver %s", receiver)
//        self.configureView()
        let myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerFunc", userInfo: nil, repeats: true)
        let query = PFQuery(className: "RSTMessage")
        NSLog(receiver)
        query.whereKey("sender", containedIn: [FbUser.user.id, receiver])
        query.whereKey("receiver", containedIn: [FbUser.user.id, receiver])
        query.addAscendingOrder("date")
        let result = query.findObjects()
        var messageArr = NSArray.array()
        if (result != nil) {
            messageArr = result as NSArray
        }
        for message in messageArr {
            self.messages.append(RSTMessage.makeJSQMessage(message as RSTMessage))
        }
        super.viewDidLoad()
    }
    
    func timerFunc() {
        let query = PFQuery(className: "RSTMessage")
        self.messages = []
        query.whereKey("sender", containedIn: [FbUser.user.id, receiver])
        query.whereKey("receiver", containedIn: [FbUser.user.id, receiver])
        query.addAscendingOrder("date")
        let result = query.findObjects()
        var messageArr = NSArray.array()
        if (result != nil) {
            messageArr = result as NSArray
        }
        for message in messageArr {
            self.messages.append(RSTMessage.makeJSQMessage(message as RSTMessage))
        }
        NSLog("%@", (self.messages.last as JSQMessage))
        self.finishReceivingMessage()
//        dispatch_async(dispatch_get_main_queue(), {
//            self.collectionView.reloadData()
//            self.scrollToBottomAnimated(true)
//        })
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, sender: String!, date: NSDate!) {
        NSLog("text: %s\n", sender)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        var message : RSTMessage = RSTMessage(sender: FbUser.user.id, receiver: receiver, content: text, date: date)
        message.saveInBackgroundWithBlock(nil)
        self.messages.append(RSTMessage.makeJSQMessage(message))
        self.finishSendingMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) ->UICollectionViewCell {
        var cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as JSQMessagesCollectionViewCell
        
        var message = self.messages[indexPath.item]
        if message.sender() == FbUser.user {
            cell.textView.textColor = UIColor.blackColor()
        } else {
            cell.textView.textColor = UIColor.whiteColor()
        }
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, bubbleImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        let message = messages[indexPath.item]
        
        if message.sender() == FbUser.user {
            return UIImageView(image: outgoingBubbleImageView.image, highlightedImage: outgoingBubbleImageView.highlightedImage)
        }
        
        return UIImageView(image: incomingBubbleImageView.image, highlightedImage: incomingBubbleImageView.highlightedImage)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        let img = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://i2.wp.com/c0589922.cdn.cloudfiles.rackspacecloud.com/avatars/male200.png")))
        return nil
    }
}

