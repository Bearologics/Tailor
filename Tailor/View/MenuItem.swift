//
//  File.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

struct MenuItem {
    static func genericErrorItem() -> NSMenuItem {
        return disabledItem("An error occured.")
    }
    
    static func loadingItem() -> NSMenuItem {
        return disabledItem("Loading…")
    }
    
    static func disabledItem(title: String) -> NSMenuItem {
        return item(title, enabled: false)
        
    }
    
    static func enabledItem(title: String) -> NSMenuItem {
        return item(title, enabled: true)
    }
        
    static func item(title: String, enabled: Bool) -> NSMenuItem {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: "")
        item.enabled = enabled
        return item
    }
}