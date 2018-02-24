//
//  Line.swift
//  Realm
//
//  Created by Karol Zmyslowski on 19.02.2018.
//  Copyright © 2018 Karol Zmyslowski. All rights reserved.
//

import Foundation
import RealmSwift


@objcMembers class Line: Object {
    
    dynamic var line: String = ""
    let score = RealmOptional<Int>()
    dynamic var email :String? = nil
    
    convenience init(line: String, score: Int?, email: String?) {
        self.init()
        self.line = line
        self.score.value = score
        self.email = email
    }
}
