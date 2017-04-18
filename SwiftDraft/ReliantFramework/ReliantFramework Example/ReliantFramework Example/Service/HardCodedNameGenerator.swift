//
//  HardCodedNameGenerator.swift
//  ReliantFramework Example
//
//  Created by Michael Seghers on 15/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

import Foundation

struct HardCodedNameGenerator : NameGenerator {
    let names = ["Gil", "Ellen", "Tim", "Heidi", "Steve", "Linda", "Craig", "Asana", "Scott", "Deborah", "Phil"]
    
    func generateName(callback:(String?, ErrorType?) -> ()) -> () {
        let index = arc4random_uniform(UInt32(names.count))
        callback(names[Int(index)], nil)
    }
    
    func generateNumberOfNames(number: UInt, callback: ([String]?, ErrorType?) -> ()) {
        callback(names, nil)
    }
}