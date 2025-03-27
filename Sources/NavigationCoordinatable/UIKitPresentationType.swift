//
//  UIKitPresentationType.swift
//  
//
//  Created by wani on 2022/04/25.
//

import SwiftUI

#if os(iOS)
public protocol UIKitPresentationType: PresentationType {
    func makeViewController<Content: View>(content: Content) -> UIViewController
    func presented(parent: UIViewController,
                   content: UIViewController,
                   onAppeared: @escaping () -> Void,
                   onDissmissed: @escaping () -> Void)
    func dismissed(viewController: UIViewController)
}

public final class ViewControllerPresented {

    init(
        viewController: UIViewController? = nil,
        presentationType: UIKitPresentationType
    ) {
        self.presentationType = presentationType
        self.strontViewController = viewController
        self.weakViewController = viewController
    }

    var presentationType: UIKitPresentationType

    var viewController: UIViewController? {
        defer { strontViewController = nil }
        return weakViewController
    }

    private var strontViewController: UIViewController?
    private weak var weakViewController: UIViewController?

    func dismiss() {
        viewController.map {
            presentationType.dismissed(viewController: $0)
        }
    }
}
#endif
