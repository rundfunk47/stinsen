import Foundation
import SwiftUI
import Combine


struct NavigationCoordinatableView<T: NavigationCoordinatable>: View {
    var coordinator: T
    private let id: Int
    private let router: NavigationRouter<T>
    @StateObject var presentationHelper: PresentationHelper<T>
    @ObservedObject var root: NavigationRoot
    
    var start: AnyView?
    
    var body: some View {
        commonView
            .environmentObject(router)
    }
    
    
    @ViewBuilder
    var rootView: some View {
        if  id == -1 {
            AnyView(coordinator.customize(AnyView(root.item.child.view())))
        } else if let start = self.start {
            start
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var commonView: some View {
        rootView
            .background(UIKitIntrospectionViewController(selector: { $0.parent }) {
                presentationHelper.setupViewController($0)
            })
    }
    
    init(id: Int, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
        self._presentationHelper = StateObject(wrappedValue: {
            PresentationHelper(
                id: id,
                coordinator: coordinator
            )
        }())

        self.router = NavigationRouter(
            id: id,
            coordinator: coordinator.routerStorable
        )

        if coordinator.stack.root == nil {
            coordinator.setupRoot()
        }

        self.root = coordinator.stack.root
        
        RouterStore.shared.store(router: router)
        
        if let presentation = coordinator.stack.value[safe: id] {
            if let view = presentation.presentable as? AnyView {
                self.start = view
            } else {
                fatalError("Can only show views")
            }
        } else if id == -1 {
            self.start = nil
        } else {
            fatalError()
        }
    }
}

// MARK: - uikit present
extension View {
    func present(presented: Presented?, onAppear: @escaping () -> Void, onDismiss: @escaping () -> Void) -> some View {
#if os(iOS)
        background(UIKitIntrospectionViewController(selector: { $0.parent }) { viewController in
            guard case let .viewController(uiKitPresented) = presented else { return }

            guard let destination = uiKitPresented.viewController else {
                return
            }
            uiKitPresented.presentationType.presented(
                parent: viewController,
                content: destination,
                onAppeared: onAppear,
                onDissmissed: onDismiss
            )
        })
#else
        self
#endif
    }
}
