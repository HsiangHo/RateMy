//
//  RMRatingWindow.swift
//  RateMy
//
//  Created by Jovi on 11/28/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa

public class RMRatingWindow: NSWindow {
    private var dislikePageController: RMPageProtocol = RMBasePageViewController.init()
    private var mainPageController: RMPageProtocol = RMBasePageViewController.init()
    private var likePageController: RMPageProtocol = RMBasePageViewController.init()
    private weak var currentPageController: RMPageProtocol?
    var completionHandler: ((UserRating) -> Void)?

    init() {
        super.init(contentRect: NSRect(x: 0, y: 0, width: 480, height: 350),
                   styleMask: [.fullSizeContentView, .titled],
                   backing: .buffered,
                   defer: true)
        self.title = ""
        self.titlebarAppearsTransparent = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        self.standardWindowButton(.fullScreenButton)?.isHidden = true
        self.contentViewController = RMBasePageViewController.init()
        self.contentViewController?.view = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 480, height: 350))
        self.center()

        mainPageController.likeButton.target = self
        mainPageController.likeButton.action = #selector(likeButton_click(sender:))
        mainPageController.dislikeButton.target = self
        mainPageController.dislikeButton.action = #selector(dislikeButton_click(sender:))
        likePageController.likeButton.target = self
        likePageController.likeButton.action = #selector(likeButton_click(sender:))
        likePageController.dislikeButton.target = self
        likePageController.dislikeButton.action = #selector(dislikeButton_click(sender:))
        dislikePageController.likeButton.target = self
        dislikePageController.likeButton.action = #selector(likeButton_click(sender:))
        dislikePageController.dislikeButton.target = self
        dislikePageController.dislikeButton.action = #selector(dislikeButton_click(sender:))

        self.contentViewController?.addChild(mainPageController)
        self.contentViewController?.addChild(likePageController)
        self.contentViewController?.addChild(dislikePageController)
        self.contentViewController?.view.addSubview(mainPageController.view)
        currentPageController = mainPageController
    }

}

extension RMRatingWindow {
    @IBAction func likeButton_click(sender: Any?) {
        guard let current = currentPageController else {
            return
        }
        if current == likePageController {
            self.orderOut(nil)
            completionHandler?(.like)
        } else if current == dislikePageController {
            self.orderOut(nil)
            completionHandler?(.dislike)
        } else {
            self.contentViewController?.transition(from: mainPageController, to: likePageController, options: .slideLeft, completionHandler: {
                self.currentPageController = self.likePageController
            })
        }
    }

    @IBAction func dislikeButton_click(sender: Any?) {
        guard let current = currentPageController else {
            return
        }
        if current == likePageController {
            self.orderOut(nil)
            completionHandler?(.none)
        } else if current == dislikePageController {
            self.orderOut(nil)
            completionHandler?(.none)
        } else {
            self.contentViewController?.transition(from: mainPageController, to: dislikePageController, options: .slideRight, completionHandler: {
                self.currentPageController = self.dislikePageController
            })
        }
    }
}

extension RMRatingWindow {
    public func configure(main: ((RMPageProtocol)-> Void),
                          like: ((RMPageProtocol)-> Void),
                          dislike: ((RMPageProtocol)-> Void)) -> RMRatingWindow {
        main(mainPageController)
        like(likePageController)
        dislike(dislikePageController)
        return self
    }
}
