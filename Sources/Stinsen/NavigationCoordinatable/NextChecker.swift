import Foundation
import Combine
import SwiftUI

class NextChecker<T: NavigationCoordinatable>: ObservableObject {
    enum Presentation {
        case push
        case modal
    }
    
    var cancellables: Set<AnyCancellable> = Set()
    
    @Published var nextPushIsActive: Bool
    @Published var nextModalIsActive: Bool

    let id: Int?
    weak var t: T?
    let children: Children
    
    private static func nextIsActive(t: T, id: Int?, children: Children, presentation: Presentation) -> Bool {
        if (id ?? 0 == t.navigationStack.value.count) {
            if presentation == .push {
                if children.activeChildCoordinator != nil {
                    return true
                }
            } else if presentation == .modal {
                if children.activeModalChildCoordinator != nil {
                    return true
                }
            }
        }
        
        guard let id = id else {
            let itemPresentation = t.navigationStack.value[safe: 0]
            
            switch itemPresentation {
            case .modal:
                return presentation == .modal
            case .push:
                return presentation == .push
            default:
                return false
            }
        }
        
        let itemPresentation = t.navigationStack.value[safe: id + 1]
        
        switch itemPresentation {
        case .modal:
            return presentation == .modal
        case .push:
            return presentation == .push
        default:
            return false
        }
    }
    
    func nextPushView() -> AnyView {
        if (id ?? 0 == t!.navigationStack.value.count) {
            if children.activeChildCoordinator != nil {
                return AnyView(
                    children.activeChildCoordinator!.coordinatorView()
                        .environmentObject(ParentCoordinator(coordinator: t!))
                )
            }
        }

        return AnyView(
            NavigationCoordinatableView(
                id: (id ?? -1) + 1,
                coordinator: t!
            )
            .environmentObject(ParentCoordinator(coordinator: t!))
        )
    }
    
    func nextModalView() -> AnyView {
        if (id ?? 0 == t!.navigationStack.value.count) {
            if children.activeModalChildCoordinator != nil {
                return AnyView(
                    children.activeModalChildCoordinator!.coordinatorView()
                        .environmentObject(ParentCoordinator(coordinator: t!))
                )
            }
        }

        return AnyView(
            NavigationCoordinatableView(
                id: (id ?? -1) + 1,
                coordinator: t!
            )
            .environmentObject(ParentCoordinator(coordinator: t!))
        )
    }
    
    init(id: Int?, _ t: T, children: Children) {
        self.id = id
        self.t = t
        self.children = children
        
        nextPushIsActive = Self.nextIsActive(
            t: t,
            id: id,
            children: children,
            presentation: .push
        )
        
        nextModalIsActive = Self.nextIsActive(
            t: t,
            id: id,
            children: children,
            presentation: .modal
        )
        
        t.navigationStack.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let nextPush = Self.nextIsActive(
                    t: t,
                    id: id,
                    children: children,
                    presentation: .push
                )
                
                if self.nextPushIsActive != nextPush {
                    self.nextPushIsActive = nextPush
                }
                
                let nextModal = Self.nextIsActive(
                    t: t,
                    id: id,
                    children: children,
                    presentation: .modal
                )
                
                if self.nextModalIsActive != nextModal {
                    self.nextModalIsActive = nextModal
                }
            }
        }.store(in: &cancellables)
        
        children.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let nextPush = Self.nextIsActive(
                    t: t,
                    id: id,
                    children: children,
                    presentation: .push
                )
                
                if self.nextPushIsActive != nextPush {
                    self.nextPushIsActive = nextPush
                }
                
                let nextModal = Self.nextIsActive(
                    t: t,
                    id: id,
                    children: children,
                    presentation: .modal
                )
                
                if self.nextModalIsActive != nextModal {
                    self.nextModalIsActive = nextModal
                }
            }
        }.store(in: &cancellables)
    }
}
