//
//  RMBasePageViewController.swift
//  RateMy
//
//  Created by Jovi on 11/28/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa

public protocol RMPageProtocol: NSViewController {
    var likeButton: NSButton {get}
    var dislikeButton: NSButton {get}
    func config(title: String,
                subtitle: String,
                likeImage: NSImage,
                dislikeImage: NSImage,
                likeButtonTitle: String,
                dislikeButtonTitle: String)
}

public class RMBasePageViewController: NSViewController {
    private lazy var btnLike: NSButton = makeButton()
    private lazy var btnDislike: NSButton = makeButton()
    private var ivLike: NSImageView = NSImageView.init()
    private var ivDislike: NSImageView = NSImageView.init()
    private var titleView: NSView = NSView.init()
    private lazy var lbTitle: NSTextField = makeLabel()
    private lazy var lbSubtitle: NSTextField = makeLabel()

    init() {
        super.init(nibName: nil, bundle: nil)
        let view = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 480, height: 350))
        self.view = view

        initializeRMBasePageViewController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initializeRMBasePageViewController() {
        btnDislike.frame = NSRect.init(x: 65, y: 40, width: 290, height: 60)
        btnLike.frame = NSRect.init(x: 125, y: 115, width: 290, height: 60)
        ivLike.frame = NSRect.init(x: 65, y: 121, width: 48, height: 48)
        ivDislike.frame = NSRect.init(x: 370, y: 46, width: 48, height: 48)
        titleView.frame = NSRect.init(x: 0, y: 210, width: 480, height: 140)
        lbTitle.frame = NSRect.init(x: 0, y: 72, width: 480, height: 40)
        lbSubtitle.frame = NSRect.init(x: 0, y: 15, width: 480, height: 50)

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(red: 235/255.0, green: 249/255.0, blue: 255/255.0, alpha: 1.0).cgColor

        titleView.wantsLayer = true
        titleView.layer?.backgroundColor = NSColor.init(red: 65/255.0, green: 185/255.0, blue: 237/255.0, alpha: 1.0).cgColor

        lbTitle.textColor = .white
        lbTitle.font = NSFont.init(name: "Helvetica Neue Light", size: 32)
        lbTitle.stringValue = ""

        lbSubtitle.attributedStringValue = makeSubtitle("")

        btnLike.attributedTitle = makeButtonTitle("")
        btnLike.layer?.backgroundColor = NSColor.init(red: 161/255.0, green: 246/255.0, blue: 136/255.0, alpha: 1.0).cgColor

        btnDislike.attributedTitle = makeButtonTitle("")
        btnDislike.layer?.backgroundColor = NSColor.init(red: 212/255.0, green: 226/255.0, blue: 232/255.0, alpha: 1.0).cgColor

        ivLike.image = nil
        ivDislike.image = nil

        view.addSubview(titleView)
        titleView.addSubview(lbTitle)
        titleView.addSubview(lbSubtitle)
        view.addSubview(btnLike)
        view.addSubview(btnDislike)
        view.addSubview(ivLike)
        view.addSubview(ivDislike)
    }
}

extension RMBasePageViewController {
    func makeLabel() -> NSTextField {
        let label = NSTextField.init(frame: NSRect.zero)
        label.isBezeled = false
        label.isEditable = false
        label.isBordered = false
        label.drawsBackground = false
        label.alignment = .center
        return label
    }

    func makeButton() -> NSButton {
        let button = NSButton.init(frame: NSRect.zero)
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.cornerRadius = 30
        button.font = NSFont(name:"Helvetica Neue", size:18)
        return button
    }

    func makeSubtitle(_ subtitle: String) -> NSAttributedString {
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.alignment = NSTextAlignment.center
        attributedStringParagraphStyle.lineSpacing = 7.0

        let attributedString = NSAttributedString(string: subtitle,
                                                  attributes: [NSAttributedString.Key.foregroundColor: NSColor.init(red: 31/255.0, green: 114/255.0, blue: 142/255.0, alpha: 1.0),
                                                               NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,
                                                               NSAttributedString.Key.font: NSFont(name:"Helvetica Neue Light", size:14.0)!])
        return attributedString
    }

    func makeButtonTitle(_ title: String) -> NSAttributedString {
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.alignment = NSTextAlignment.center

        let attributedString = NSAttributedString(string: title,
                                                  attributes: [NSAttributedString.Key.foregroundColor: NSColor.init(red: 128/255.0, green: 152/255.0, blue: 151/255.0, alpha: 0.95),
                                                               NSAttributedString.Key.paragraphStyle: attributedStringParagraphStyle,NSAttributedString.Key.font:NSFont(name:"Helvetica Neue", size:18.0)!])
        return attributedString
    }
}


extension RMBasePageViewController: RMPageProtocol {
    public func config(title: String, subtitle: String, likeImage: NSImage, dislikeImage: NSImage, likeButtonTitle: String, dislikeButtonTitle: String) {
        lbTitle.stringValue = title
        lbSubtitle.attributedStringValue = makeSubtitle(subtitle)
        ivLike.image = likeImage
        ivDislike.image = dislikeImage
        btnLike.attributedTitle = makeButtonTitle(likeButtonTitle)
        btnDislike.attributedTitle = makeButtonTitle(dislikeButtonTitle)
    }
    
    public var likeButton: NSButton {
        return btnLike
    }

    public var dislikeButton: NSButton {
        return btnDislike
    }
}
