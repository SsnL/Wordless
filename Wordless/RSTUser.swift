//
//  RSTUser.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
class RSTUser: PFUser, PFSubclassing {
    @NSManaged var name: String!
    @NSManaged var friends_dic: NSDictionary?
    @NSManaged var id: String!

    override class func load() {
        self.registerSubclass()
    }

    override init() {
        super.init()
    }

    init(name n: String!, id i: String!) {
        super.init()
        name = n
        id = i
    }

    init(graphObj u: FBGraphObject) {
        super.init()
        name = u.objectForKey("name") as String!
        friends_dic = nil
        id = u.objectForKey("id") as String!
    }
}
