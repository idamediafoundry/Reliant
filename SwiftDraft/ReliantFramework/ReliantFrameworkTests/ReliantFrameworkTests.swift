//
//  ReliantFrameworkTests.swift
//  ReliantFrameworkTests
//
//  Created by Michael Seghers on 11/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

import XCTest
@testable import Reliant


struct PrototypedContext : ReliantContext {
    private let bothWorlds:BothWorlds
    
    let waver:Waver
    let greeter:Greeter
    
    init(prefix:String) {
        ReliantFrameworkTestsHelper.sharedInsance.markInitCalled()
        bothWorlds = BothWorlds(prefix:prefix)
        waver = bothWorlds
        greeter = bothWorlds
    }
    
    static func createContext() -> (String) -> (PrototypedContext) {
        return {
            return PrototypedContext(prefix: $0)
        }
    }
}

struct GreeterNeeding {
    private let greeter:Greeter
    
    init(greeter:Greeter) {
        self.greeter = greeter
    }
    
    func decorateGreeting() -> String {
        return "Oh! \(greeter.greet("Needy"))"
    }
}

struct ContextNeedingContext : ReliantContext {
    private let otherContext = relyOn(SimpleValueContext)
    let needy:GreeterNeeding;
    
    init() {
        needy = GreeterNeeding(greeter: otherContext.greeter)
    }
    
    static func createContext() -> ContextNeedingContext {
        return ContextNeedingContext()
    }
}
class SubWaver : Waver {
    func wave(reason: String) -> String {
        return "Substitute waving"
    }
}

class SubstituteContext : SimpleReferenceContext {
    override init() {
        super.init()
        waver = SubWaver()
    }
}

class ReliantFrameworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        ReliantFrameworkTestsHelper.sharedInsance.reset()
        ContextCache.standard.removeAll()
    }
    
    func testRelyOnReturnsSameInsanceEveryTimeForReferenceTypes() {
        let context = relyOn(SimpleReferenceContext)
        let otherContext = relyOn(SimpleReferenceContext)
        XCTAssertTrue(context === otherContext, "Rely on didn't terurn the same instance!");
    }
    
    func testRelyOnReturnDoesntCallInitMoreThenOnceForValueTypes() {
        _ = relyOn(SimpleValueContext)
        _ = relyOn(SimpleValueContext)
        XCTAssertEqual(ReliantFrameworkTestsHelper.sharedInsance.initCalled, 1);
    }
    
    func testCanRelyOnOtherContextInOtherContext() {
        let needed = relyOn(ContextNeedingContext)
        XCTAssertEqual(needed.needy.decorateGreeting(), "Oh! Hello Needy")
    }
    
    func testSubstitutions() {
        relyOnSubstitute(SimpleReferenceContext)(SubstituteContext)
        XCTAssertTrue(ContextCache.substitutions.contains({ (key, value) -> Bool in
            return key == String(SimpleReferenceContext) && value == SubstituteContext.self
        }))
        
        let context = relyOn(SimpleReferenceContext)
                
        // Failing test.
        // The createContext() function is static and thus final. Actual context type seems
        // to be correct, but createContext() is called on original context class
        XCTAssertTrue(context is SubstituteContext)
    }
}
