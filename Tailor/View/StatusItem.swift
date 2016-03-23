//
//  StatusItem.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

struct StatusItem {
    static func icon() -> NSImage {
        let icon = NSImage(named: "statusIcon")!
        icon.template = true
        return icon
    }
}
