//
//  AppDelegate.swift
//  RateMyDemo
//
//  Created by Jovi on 11/23/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa
import RateMy

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let alert = RateMy.request { (rating) in
        // Handle the rating result here
        print(rating)
    }.configure(main: { (mainPage) in
        mainPage.config(title: "Happy with XXX",
        subtitle: "Did you enjoy using our app?\n Would you mind taking a moment to rate it?",
        likeImage: NSImage.init(named: "like")!,
        dislikeImage: NSImage.init(named: "dislike")!,
        likeButtonTitle: "YES, IT'S GREAT!",
        dislikeButtonTitle: "NO, NOT SO MUCH...")
    }, like: { (likePage) in
        likePage.config(title: "You're great!",
        subtitle: "If you enjoyed using our app, would you mind taking a moment to rate it? Thank you for your support!",
        likeImage: NSImage.init(named: "like")!,
        dislikeImage: NSImage.init(named: "dislike")!,
        likeButtonTitle: "RATE XXX",
        dislikeButtonTitle: "NO THANKS")
    }) { (dislikePage) in
        dislikePage.config(title: "Sorry to hear that...",
        subtitle: "Let us know what didn't work for you, it will help us improve XXX.",
        likeImage: NSImage.init(named: "contact")!,
        dislikeImage: NSImage.init(named: "dislike")!,
        likeButtonTitle: "GET IN TOUCH",
        dislikeButtonTitle: "NO THANKS")
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        alert.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

