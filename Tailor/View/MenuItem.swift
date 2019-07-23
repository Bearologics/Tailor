//
//  File.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

class MenuItem: NSMenuItem {
    var url: URL?
    
    static func genericErrorItem() -> NSMenuItem {
        return disabledItem("An error occured.")
    }
    
    static func loadingItem() -> NSMenuItem {
        return disabledItem("Loading…")
    }
    
    static func disabledItem(_ title: String) -> NSMenuItem {
        return item(nil, title: title, url: nil, enabled: false)
        
    }
    
    static func enabledItem(_ title: String, url: URL?) -> NSMenuItem {
        return item(nil, title: title, url: url, enabled: true)
    }
    
    static func openUrlItem(_ target: StatusItemController, title: String, url: URL?) -> NSMenuItem {
        return item(target, title: title, url: url, enabled: true)
    }
    
    static func item(_ target: StatusItemController?, title: String, url: URL?, enabled: Bool) -> NSMenuItem {
        let item = MenuItem()
        if let t = target {
            item.target = target
            item.action = #selector(t.openUrl(_:))
        }
        item.title = title
        item.url = url
        item.isEnabled = enabled
        return item
    }
    
    static func refreshItem(_ target: StatusItemController) -> NSMenuItem {
        let item = MenuItem(title: "Refresh", action: #selector(target.refresh(_:)), keyEquivalent: "")
        item.target = target
        return item
    }
    
    static func closeItem(_ target: StatusItemController) -> NSMenuItem {
        let item = MenuItem(title: "Quit", action: #selector(target.closeApp(_:)), keyEquivalent: "")
        item.target = target
        return item
    }
}
