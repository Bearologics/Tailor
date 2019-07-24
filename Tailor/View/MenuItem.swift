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
    
    static func genericErrorItem() -> MenuItem {
        return errorItem(message: "An error occured.")
    }
    
    static func errorItem(message: String) -> MenuItem {
        return disabledItem(message)
    }
    
    static func loadingItem() -> MenuItem {
        return disabledItem("Loading…")
    }
    
    static func disabledItem(_ title: String) -> MenuItem {
        return item(nil, title: title, url: nil, enabled: false)
        
    }
    
    static func enabledItem(_ title: String, url: URL?) -> MenuItem {
        return item(nil, title: title, url: url, enabled: true)
    }
    
    static func openUrlItem(_ target: StatusItemController, title: String, url: URL?) -> MenuItem {
        return item(target, title: title, url: url, enabled: true)
    }
    
    static func item(_ target: StatusItemController?, title: String, url: URL?, enabled: Bool) -> MenuItem {
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
    
    static func refreshItem(_ target: StatusItemController) -> MenuItem {
        let item = MenuItem(title: "Refresh", action: #selector(target.refresh(_:)), keyEquivalent: "")
        item.target = target
        return item
    }
    
    static func closeItem(_ target: StatusItemController) -> MenuItem {
        let item = MenuItem(title: "Quit", action: #selector(target.closeApp(_:)), keyEquivalent: "")
        item.target = target
        return item
    }
}
