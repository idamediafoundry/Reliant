//
//  SimpleReferenceContext.swift
//  ReliantFramework
//
//  Created by Michael Seghers on 11/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

import Foundation
import Reliant

class SimpleReferenceContext : ReliantContext {
    private let bothWorlds = BothWorlds(prefix:"Hello")
    
    var waver:Waver
    var greeter:Greeter
    
    init() {
        ReliantFrameworkTestsHelper.sharedInsance.markInitCalled()
        waver = bothWorlds
        greeter = bothWorlds
    }
    
    static func createContext() -> SimpleReferenceContext {
        return SimpleReferenceContext()
    }
}
