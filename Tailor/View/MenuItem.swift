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
    
    static func disabledItem(_ title: String) -> NSMenuItem {
        return item(nil, title: title, enabled: false)
        
    }
    
    static func enabledItem(_ title: String) -> NSMenuItem {
        return item(nil, title: title, enabled: true)
    }
    
    static func openUrlItem(_ target: StatusItemController, title: String) -> NSMenuItem {
        return item(target, title: title, enabled: true)
    }
    
    static func item(_ target: StatusItemController?, title: String, enabled: Bool) -> NSMenuItem {
        let item = NSMenuItem()
        if let t = target {
            item.target = target
            item.action = #selector(t.openUrl(_:))
        }
        item.title = title
        item.isEnabled = enabled
        return item
    }
    
    static func closeItem(_ target: StatusItemController) -> NSMenuItem {
        let item = NSMenuItem(title: "Quit", action: #selector(target.closeApp(_:)), keyEquivalent: "")
        item.target = target
        return item
    }
}
