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
    var read: Bool!
//    var sentiment: Int!
}
