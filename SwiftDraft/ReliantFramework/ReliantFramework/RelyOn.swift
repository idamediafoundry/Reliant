//
//  RelyOn.swift
//  ReliantFramework
//
//  Created by Michael Seghers on 11/01/16.
//  Copyright © 2016 AppFoundry. All rights reserved.
//

import Foundation

struct ContextCache {
    typealias ContextCacheType = Dictionary<String, Any>

    // If we're only going to use a static cache, we might as well use a struct?
    static var standard = ContextCacheType()
}

public func relyOn<T:ReliantContext>(type:T.Type) -> T.ContextType {
    if let result = ContextCache.standard[String(type)] {
        // Forced downcast could be dangerous?
        return result as! T.ContextType
    } else {
        let result = type.createContext()
        ContextCache.standard[String(type)] = result
        return result;
    }
}