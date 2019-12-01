//
//  RateMy.swift
//  RateMy
//
//  Created by Jovi on 11/28/19.
//  Copyright © 2019 Jovi. All rights reserved.
//

import Cocoa

public enum UserRating: Int{
    case none = -1
    case dislike
    case like
}

public class RateMy {
    public static func request(completionHandler: @escaping (UserRating) -> Void) -> RMRatingWindow {
        let window = RMRatingWindow.init()
        window.completionHandler = completionHandler
        return window
    }
}
