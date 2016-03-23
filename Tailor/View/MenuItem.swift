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
        return item(nil, title: title, enabled: false)
        
    }
    
    static func enabledItem(title: String) -> NSMenuItem {
        return item(nil, title: title, enabled: true)
    }
    
    static func openUrlItem(target: AnyObject, title: String) -> NSMenuItem {
        return item(target, title: title, enabled: true)
    }
    
    static func item(target: AnyObject?, title: String, enabled: Bool) -> NSMenuItem {
        let item = NSMenuItem()
        item.target = target
        if item.target != nil {
            item.action = "openUrl:"
        }
        item.title = title
        item.enabled = enabled
        return item
    }
    
    static func closeItem(target: AnyObject) -> NSMenuItem {
        let item = NSMenuItem(title: "Quit", action: "closeApp:", keyEquivalent: "")
        item.target = target
        return item
    }
}