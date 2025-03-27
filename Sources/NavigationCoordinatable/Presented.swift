import SwiftUI



public enum Presented {

    case viewController(ViewControllerPresented)


    public var type: PresentationType {
        switch self {
        case let .viewController(presented):
            return presented.presentationType
        }
    }
    
}

