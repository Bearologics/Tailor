//
//  StatusItemController.swift
//  Tailor
//
//  Created by Marcus Kida on 23/03/2016.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

import Cocoa
import XCModel

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
    
    func showError(message: String?) {
        menu.removeAllItems()
        if let message = message {
            menu.addItem(
                MenuItem.errorItem(message: message)
            )
        } else {
            menu.addItem(
                MenuItem.genericErrorItem()
            )
        }
        self.menu.addItem(MenuItem.refreshItem(self))
        self.menu.addItem(MenuItem.separator())
        self.addCloseItems()
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        guard menu.items.count == 0 else {
            return
        }
        if menu != self.menu {
            return
        }
        refreshItems()
    }
    
    private func refreshItems() {
        menu.removeAllItems()
        menu.addItem(
            MenuItem.loadingItem()
        )
        self.addCloseItems()
        fetcher.getReleases { [weak self] entries, error in
            guard let self = self else { return }
            if let error = error {
                switch error {
                case .noData(let errorString):
                    self.showError(message: errorString)
                }
                return
            }
            guard let entries = entries else {
                return self.showError(message: nil)
            }
            self.menu.removeAllItems()
            self.menu.addItem(MenuItem.refreshItem(self))
            self.menu.addItem(MenuItem.separator())
            
            Dictionary(grouping: entries, by: { $0.version.number ?? "Unknown" })
                .sorted { $0.key.localizedStandardCompare($1.key) == .orderedDescending }
                .map { xcodes in
                self.xcodeVersionMenuGroupItem("Xcode \(xcodes.key)", xcodes: xcodes.value)
            }.forEach { self.menu.addItem($0) }

            self.addCloseItems()
        }
    }
    
    func addCloseItems() {
        menu.addItem(NSMenuItem.separator())
        menu.addItem(MenuItem.disabledItem(NSApplication.formattedVersion()))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(MenuItem.closeItem(self))
    }
    
    private func xcodeVersionMenuGroupItem(_ version: String, xcodes: [Xcode]) -> NSMenuItem {
        let item = NSMenuItem(title: version, action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        xcodes.forEach { xcode in
            submenu.addItem(xcodeVersionReleaseMenuItem(xcode))
        }
        item.submenu = submenu
        return item
    }
    
    private func xcodeVersionReleaseMenuItem(_ entry: Xcode) -> NSMenuItem {
        let item = NSMenuItem(title: "\(entry.name) \(entry.version.number ?? "") \(entry.getReleaseSuffix()) (\(entry.version.build))", action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        if let notes = entry.links?.notes {
            submenu.addItem(MenuItem.openUrlItem(self, title: "Release Notes", url: notes.url))
        }
        if let download = entry.links?.download {
            submenu.addItem(MenuItem.openUrlItem(self, title: "Download", url: download.url))
        }
        item.submenu = submenu
        return item
    }

    @objc func openUrl(_ sender: MenuItem) {
        guard let url = sender.url else { return }
        NSWorkspace.shared.open(url)
    }
    
    @objc func refresh(_ sender: MenuItem) {
        refreshItems()
    }
    
    @objc func closeApp(_ sender: MenuItem) {
        NSApplication.shared.terminate(sender)
    }
    
}
