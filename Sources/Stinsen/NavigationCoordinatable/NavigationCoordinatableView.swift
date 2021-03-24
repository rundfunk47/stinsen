import Foundation
import SwiftUI
import Combine

struct NavigationCoordinatableView<T: NavigationCoordinatable>: View {
    var coordinator: T
    private let id: Int
    @EnvironmentObject private var root: RootCoordinator
    private let router: NavigationRouter<T.Route>
    private let start: AnyView
    @ObservedObject var presentationHelper: PresentationHelper<T>
    
    var body: some View {
        self.start
            .background(
                NavigationLink(
                    destination: { () -> AnyView in
                        if let view = presentationHelper.presented?.view {
                            return AnyView(view.environmentObject(root))
                        } else {
                            return AnyView(EmptyView())
                        }
                    }(),
                    isActive: Binding<Bool>.init(get: { () -> Bool in
                        return presentationHelper.presented?.isPush == true
                    }, set: { _ in
                             
                    }),
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            .onAppear(perform: {
                self.router.root = root.coordinator
                
                if self.presentationHelper.presented != nil {
                    // Pressed back button
                    self.coordinator.navigationStack.popTo(self.id)
                } else {
                    // Dismissing through dismissal-function or other means
                    DispatchQueue.main.async {
                        self.coordinator.childDismissalAction()
                        self.coordinator.childDismissalAction = {}
                    }
                }
            })
            .sheet(isPresented: Binding<Bool>.init(get: { () -> Bool in
                return presentationHelper.presented?.isModal == true
            }, set: { _ in
            
            }), onDismiss: {
                // shouldn't matter if different coordinators. also this set modal children to nil
                self.coordinator.navigationStack.popTo(self.id)
                
                DispatchQueue.main.async {
                    self.coordinator.childDismissalAction()
                    self.coordinator.childDismissalAction = {}
                }
            }, content: { () -> AnyView in
                return { () -> AnyView in
                    if let view = presentationHelper.presented?.view {
                        return AnyView(view.environmentObject(root))
                    } else {
                        return AnyView(EmptyView())
                    }
                }()
            })
            .environmentObject(router)
    }
    
    init(id: Int, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
        
        self.presentationHelper = PresentationHelper(
            id: self.id,
            coordinator: coordinator
        )
        
        self.router = NavigationRouter(
            id: id,
            coordinator: coordinator
        )

        if let presentation = coordinator.navigationStack.value[safe: id] {
            if let view = presentation.presentable as? AnyView {
                self.start = view
            } else {
                fatalError("Can only show views")
            }
        } else if id == -1 {
            self.start = AnyView(
                coordinator
                    .start()
            )
        } else {
            fatalError()
        }
    }
}
