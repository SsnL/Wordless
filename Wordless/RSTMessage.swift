//
//  RSTMessage.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
class RSTMessage: PFObject {
    var sender: PFUser?
    var receiver: PFUser?
    var content: String?
    var date: NSDate?
    var read: Bool!
//    var sentiment: Int!

//    static func makeJSQMessage(m : RSTMessage) -> JSQMessage {
//        return JSQMessage(text: m.content!, sender: m.sender.name, date: m.date!)
//    }
//    int sentiment
}
