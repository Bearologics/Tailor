//
//  StatusItemController.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa

class StatusItemController: NSObject, NSMenuDelegate {
    
    @IBOutlet weak var menu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    let fetcher = SnapshotFetcher()
    
    override func awakeFromNib() {
        statusItem.image = StatusItem.icon()
        statusItem.menu = menu
    }
    
    @IBAction func quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
    func showError() {
        menu.removeAllItems()
        menu.addItem(
            MenuItem.genericErrorItem()
        )
    }
    
    func menuWillOpen(menu: NSMenu) {
        menu.removeAllItems()
        menu.addItem(
            MenuItem.loadingItem()
        )
        fetcher.getReleases { entries in
            guard let i = entries else {
                return self.showError()
            }
            menu.removeAllItems()
            i.map { entry in
                return MenuItem.item(entry.title, enabled: entry.enabled)
            }.forEach { menu.addItem($0) }
        }
    }
}
