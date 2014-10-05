//
//  RSTMessage.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
class RSTMessage: PFObject, PFSubclassing {
    var sender: RSTUser?
    var receiver: RSTUser?
    var content: String?
    var date: NSDate?
    var read: Bool!
//    var sentiment: Int!
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Message"
    }
    
    init(sender s: RSTUser, receiver r: RSTUser, content c: String, date d: NSDate) {
        super.init()
        sender = s
        receiver = r
        content = c
        date = d
        read = false
    }

    class func makeJSQMessage(m : RSTMessage) -> JSQMessage {
        return JSQMessage(text: m.content!, sender: m.sender!.name, date: m.date!)
    }
//    int sentiment
}
