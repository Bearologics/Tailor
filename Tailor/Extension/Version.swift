//
//  Version.swift
//  Tailor
//
//  Created by Marcus Kida on 26/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

extension NSApplication {
    class func shortVersionString() -> String {
        guard let infoDict = NSBundle.infoDictionary() else {
            return "Unknown"
        }
        return infoDict["CFBundleShortVersionString"] as! String
    }
    
    class func buildVersionString() -> String {
        guard let infoDict = NSBundle.infoDictionary() else {
            return "?"
        }
        return infoDict["CFBundleVersion"] as! String
    }
    
    class func formattedVersion() -> String {
        return "Version \(shortVersionString()) (\(buildVersionString()))"
    }
}