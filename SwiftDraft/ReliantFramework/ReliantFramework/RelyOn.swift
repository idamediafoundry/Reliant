//
//  RelyOn.swift
//  ReliantFramework
//
//  Created by Michael Seghers on 11/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

import Foundation

struct ContextCache {
    // If we're only going to use a static cache, we might as well use a struct?
    static var standard = [String:Any]()
    
    static var substitutions = [String:Any.Type]()
}

public func relyOn<T:ReliantContext>(type:T.Type) -> T.ContextType {
    let typeKey = String(type)
    if let result = ContextCache.standard[typeKey] {
        return result as! T.ContextType
    } else {
        var result:T.ContextType
        
        if let substitutionType = ContextCache.substitutions[typeKey] as? T.Type {
            result = substitutionType.createContext()
        } else {
            result = type.createContext()
        }
        
        ContextCache.standard[String(type)] = result
        return result;
    }
}

public func relyOnSubstitute<T:ReliantContext>(type:T.Type)(_ otherType:T.Type) {
    ContextCache.substitutions[String(type)] = otherType
}