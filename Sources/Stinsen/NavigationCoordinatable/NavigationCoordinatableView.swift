import Foundation
import SwiftUI

struct NavigationCoordinatableView<T: NavigationCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    private let id: Int?
    @ObservedObject private var next: NextChecker<T>
    @EnvironmentObject private var root: RootCoordinator
    @EnvironmentObject private var parent: ParentCoordinator
    private let router: NavigationRouter<T>
    private let start: AnyView
    
    var body: some View {
        if self.router.parent == nil {
            self.router.parent = parent.coordinator
        }
        
        guard let id = id else {
            return AnyView(
                start
                    .onDisappear(perform: {
                        // check if coordinator is at top before removing. not the best solution but meh...
                        if parent.coordinator!.children.activeChildCoordinator?.id == coordinator.id && coordinator.navigationStack.value.count == 0 && parent.coordinator!.isNavigationCoordinator {
                            parent.coordinator!.children.activeChildCoordinator = nil
                        } else if parent.coordinator!.children.activeModalChildCoordinator?.id == coordinator.id && coordinator.navigationStack.value.count == 0 {
                            parent.coordinator!.children.activeModalChildCoordinator = nil
                        }
                    })
                    .sheet(isPresented: Binding<Bool>.init(get: { () -> Bool in
                        return next.nextModalIsActive
                    }, set: { _ in
                        
                    }), onDismiss: {

                    }, content: {
                        next.nextModalView()
                    })
                    .environmentObject(router)
                    .background(
                        NavigationLink(
                            destination: next.nextPushView(),
                            isActive: Binding<Bool>.init(get: { () -> Bool in
                                return next.nextPushIsActive
                            }, set: { _ in
                                
                            }),
                            label: {
                                EmptyView()
                            }
                        )
                        .hidden()
                    )
            )
        }
                
        let presentation = coordinator.navigationStack.value[id]
        
        let resolved = coordinator.resolveRoute(route: presentation.route)
        
        if let resolved = resolved.presentable as? AnyView {
            return AnyView(
                resolved
                    .onDisappear(perform: {
                        // check if coordinator is at top before removing. not the best solution but meh...
                        if root.coordinator.children.containsChild(child: coordinator.eraseToAnyCoordinatable()) {
                            if coordinator.navigationStack.value.count - 1 == id {
                                coordinator.navigationStack.value.remove(at: id)
                            }
                        }
                    })
                    .sheet(isPresented: Binding<Bool>.init(get: { () -> Bool in
                        return next.nextModalIsActive
                    }, set: { _ in
                        
                    }), onDismiss: {

                    }, content: {
                        next.nextModalView()
                    })
                    .environmentObject(router)
                    .background(
                        NavigationLink(
                            destination: next.nextPushView(),
                            isActive: Binding<Bool>.init(get: { () -> Bool in
                                return next.nextPushIsActive
                            }, set: { _ in
                                
                            }),
                            label: {
                                EmptyView()
                            }
                        )
                        .hidden()
                    )
            )
        } else {
            fatalError("Routes in stack should only contain views. Coordinators are added in the Children-class")
        }
    }
    
    init(id: Int?, coordinator: T) {
        self.id = id
        self.coordinator = coordinator
        self.children = coordinator.children
        self.next = NextChecker(
            id: id,
            coordinator,
            children: coordinator.children
        )
        self.router = NavigationRouter(
            id: id,
            coordinator: coordinator,
            parent: nil // to be set later...
        )
        self.start = AnyView(coordinator.start())
    }
}
