import Foundation
import Combine
import SwiftUI

class PresentationHelper<T: NavigationCoordinatable>: ObservableObject {
    private let id: Int
    let navigationStack: NavigationStack<T.Route>
    private var cancellables = Set<AnyCancellable>()
    
    @Published var presented: Presented?
    
    func presentedChildren(
        id: Int,
        coordinator: T,
        value: [Presentation<T.Route>],
        children: Children
    ) {
        if let activeChildCoordinator = children.activeChildCoordinator, id == value.count - 1, self.presented == nil {
            self.presented = .push(
                activeChildCoordinator.coordinatorView()
            )
        } else if let activeModalChildCoordinator = children.activeModalChildCoordinator, id == value.count - 1, self.presented == nil {
            self.presented = .modal(
                activeModalChildCoordinator.coordinatorView()
            )
        } else if children.activeModalChildCoordinator == nil, children.activeChildCoordinator == nil, presented != nil, id == value.count - 1 {
            self.presented = nil
        }
    }
    
    func presentedStack(
        id: Int,
        coordinator: T,
        value: [Presentation<T.Route>],
        children: Children
    ) {
        let nextId = id + 1
        
        // Only apply updates on last screen in navigation stack
        // This check is important to get the behaviour as using a bool-state in the view that you set
        if value.count - 1 == nextId, self.presented == nil {
            if let value = value[safe: nextId] {
                let view = AnyView(NavigationCoordinatableView(id: nextId, coordinator: coordinator))
                    switch value {
                    case .modal:
                        self.presented = .modal(
                            AnyView(
                                NavigationView(
                                    content: {
                                        view
                                    }
                                )
                                .navigationViewStyle(StackNavigationViewStyle())
                            )
                        )
                    case .push:
                        self.presented = .push(
                            view
                        )
                    }
            } else {
                fatalError()
            }
        }
    }
    
    init(id: Int, coordinator: T) {
        self.id = id
        self.navigationStack = coordinator.navigationStack
        
        self.presentedStack(
            id: id,
            coordinator: coordinator,
            value: coordinator.navigationStack.value,
            children: coordinator.children
        )
        
        self.presentedChildren(
            id: id,
            coordinator: coordinator,
            value: coordinator.navigationStack.value,
            children: coordinator.children
        )
        
        navigationStack.objectWillChange.sink { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.presentedStack(
                    id: id,
                    coordinator: coordinator,
                    value: coordinator.navigationStack.value,
                    children: coordinator.children
                )
            }
        }
        .store(in: &cancellables)
        
        navigationStack.poppedTo.filter { int -> Bool in int <= id }.sink { [weak self] int in
            // remove any and all presented views if my id is less than or equal to the view being popped to!
            DispatchQueue.main.async { [weak self] in
                self?.presented = nil
                
                if coordinator.children.activeChildCoordinator != nil {
                    coordinator.children.activeChildCoordinator = nil
                }
                
                if coordinator.children.activeModalChildCoordinator != nil {
                    coordinator.children.activeModalChildCoordinator = nil
                }
            }
        }
        .store(in: &cancellables)
        
        coordinator.children.objectWillChange.sink { [weak self] value in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.presentedChildren(
                    id: id,
                    coordinator: coordinator,
                    value: coordinator.navigationStack.value,
                    children: coordinator.children
                )
            }
        }
        .store(in: &cancellables)
    }
}
