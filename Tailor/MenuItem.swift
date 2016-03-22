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
    
    static func disabledItem(text: String) -> NSMenuItem {
        let item = NSMenuItem(title: text, action: nil, keyEquivalent: "")
        item.enabled = false
        return item
    }
}