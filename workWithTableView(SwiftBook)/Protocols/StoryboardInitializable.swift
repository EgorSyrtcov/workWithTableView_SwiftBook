//
//  StoryboardInitializable.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 2/26/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {
    @nonobjc static var storyboardName: String { get }
    static func initFromStoryboard() -> Self
}

extension StoryboardInitializable where Self: UIViewController {
    @nonobjc static var storyboardName: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard() -> Self {
        guard
            let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? Self
            else {
                fatalError("Could not instantiate initial view controller from \(storyboardName) storyboard.")
        }
        return viewController
    }
}

