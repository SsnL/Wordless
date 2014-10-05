//
//  RSTUser.swift
//  Wordless
//
//  Created by hr_zhu on 14-10-4.
//  Copyright (c) 2014 RST. All rights reserved.
//

import Foundation
class RSTUser: PFUser {
    var name: String!
    var friends_dic: NSDictionary!
    
    init(name: String!) {
        super.init()
        self.name = name
    }
}
