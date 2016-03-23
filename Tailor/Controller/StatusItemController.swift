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
        if menu != self.menu {
            return
        }
        menu.removeAllItems()
        menu.addItem(
            MenuItem.loadingItem()
        )
        self.addCloseItems()
        fetcher.getReleases { entries in
            guard let i = entries else {
                return self.showError()
            }
            menu.removeAllItems()
            i.map { release in
                return self.menuItem(release)
            }.forEach { menu.addItem($0) }
            self.addCloseItems()
        }
    }
    
    func addCloseItems() {
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(MenuItem.closeItem(self))
    }
    
    func menuItem(entry: Release) -> NSMenuItem {
        let item = NSMenuItem(title: entry.title, action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        entry.hrefs.forEach { href in
            submenu.addItem(MenuItem.openUrlItem(self, title: href))
        }
        item.submenu = submenu
        return item
    }
    
    func openUrl(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: sender.title)!)
    }
    
    func closeApp(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
}
