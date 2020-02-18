//
//  AppDelegate.swift
//  LinkIt
//
//  Created by Luis Guette on 2/16/20.
//  Copyright © 2020 Luis Guette. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        item?.button?.image = NSImage(named: "link")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Link It", action: #selector(AppDelegate.linkIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func linkIt() {
        if let items = NSPasteboard.general.pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text") {
                        if let urlString = item.string(forType: type) {
                            NSPasteboard.general.clearContents()
                            
                            var actualUrl = ""
                            
                            if urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
                                actualUrl = urlString
                            } else {
                                actualUrl = "http://\(urlString)"
                            }
                            
                            NSPasteboard.general.setString("<a href=\"\(actualUrl)\">\(actualUrl)</a>", forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                            
                            NSPasteboard.general.setString(actualUrl, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        }
                    }
                }
            }
        }
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}

