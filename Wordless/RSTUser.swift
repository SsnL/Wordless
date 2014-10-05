//
//  RSTUser.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
class RSTUser: PFUser, PFSubclassing {
    var name: String!
    var friends_dic: NSDictionary?
    
    override class func load() {
        self.registerSubclass()
    }
    
    override init() {
        super.init()
    }
    
    init(name n: String!) {
        name = n
        super.init()
    }
    
    init(graphObj u: FBGraphObject) {
        name = u.objectForKey("name") as String!
        friends_dic = nil
        super.init()
    }
}
