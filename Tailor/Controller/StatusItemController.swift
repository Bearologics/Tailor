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
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let fetcher = SnapshotFetcher()
    
    override func awakeFromNib() {
        statusItem.image = StatusItem.icon()
        statusItem.menu = menu
    }
    
    @IBAction func quit(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(sender)
    }
    
    func showError() {
        menu.removeAllItems()
        menu.addItem(
            MenuItem.genericErrorItem()
        )
    }
    
    func menuWillOpen(_ menu: NSMenu) {
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
        menu.addItem(NSMenuItem.separator())
        menu.addItem(MenuItem.disabledItem(NSApplication.formattedVersion()))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(MenuItem.closeItem(self))
    }
    
    func menuItem(_ entry: Release) -> NSMenuItem {
        let item = NSMenuItem(title: entry.version.build, action: nil, keyEquivalent: "")
        let submenu = NSMenu()
//        entry.hrefs.forEach { href in
//            submenu.addItem(MenuItem.openUrlItem(self, title: href))
//        }
        item.submenu = submenu
        return item
    }
    
    @objc func openUrl(_ sender: NSMenuItem) {
        NSWorkspace.shared.open(URL(string: sender.title)!)
    }
    @objc  
    func closeApp(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(sender)
    }
    
}
