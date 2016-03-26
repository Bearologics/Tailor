//
//  InfoDictionary.swift
//  Tailor
//
//  Created by Marcus Kida on 26/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

extension NSBundle {
    static func infoDictionary() -> [String: AnyObject]? {
        return NSBundle.mainBundle().infoDictionary
    }
}
