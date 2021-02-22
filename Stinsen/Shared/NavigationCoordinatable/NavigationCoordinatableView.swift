import Foundation
import SwiftUI

struct NavigationCoordinatableView<T: NavigationCoordinatable>: View {
    var coordinator: T
    @ObservedObject var children: Children
    private let id: Int?
    @ObservedObject private var next: NextChecker<T>
    @EnvironmentObject private var root: NavigationRootCoordinator
    @EnvironmentObject private var parent: ParentCoordinator
    private let router: NavigationRouter<T>
    
    var body: some View {
        if self.router.parent == nil {
            self.router.parent = parent.coordinator
        }
        
        guard let id = id else {
            return AnyView(
                coordinator.start()
                    .onDisappear(perform: {
                        // check if coordinator is at top before removing. not the best solution but meh...
                        if parent.coordinator!.children.activeChildCoordinator?.id == coordinator.id && coordinator.navigationStack.value.count == 0 && parent.coordinator!.isNavigationCoordinator {
                            parent.coordinator!.children.activeChildCoordinator = nil
                        }
                    })
                    .sheet(isPresented: Binding<Bool>.init(get: { () -> Bool in
                        return children.activeModalChildCoordinator != nil
                    }, set: { _ in
                        
                    }), onDismiss: {
                        children.activeModalChildCoordinator = nil
                    }, content: {
                        children.activeModalChildCoordinator!.coordinatorView().environmentObject(ParentCoordinator(coordinator: self.coordinator))
                    })
                    .environmentObject(router)
                    .background(
                        NavigationLink(
                            destination: next.nextView(),
                            isActive: Binding<Bool>.init(get: { () -> Bool in
                                return next.nextIsActive
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
        
        let view: AnyView
        
        guard let route = coordinator.navigationStack.value[safe: id] else {
            return AnyView(EmptyView())
        }
        
        let resolved = coordinator.resolveRoute(route: route)
        
        switch resolved {
        case .push(let resolved):
            if let resolved = resolved as? AnyView {
                view = resolved
            } else {
                fatalError()
            }
        case .modal:
            fatalError()
        }
        
        return AnyView(
            view
                .onDisappear(perform: {
                    // check if coordinator is at top before removing. not the best solution but meh...
                    if root.coordinator.children.containsChild(child: coordinator.eraseToAnyCoordinatable()) {
                        if coordinator.navigationStack.value.count - 1 == id {
                            coordinator.navigationStack.value.remove(at: id)
                        }
                    }
                })
                .environmentObject(router)
                .background(
                    NavigationLink(
                        destination: next.nextView(),
                        isActive: Binding<Bool>.init(get: { () -> Bool in
                            return next.nextIsActive
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
    }
}
