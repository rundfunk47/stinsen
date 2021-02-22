import Foundation
import Combine
import SwiftUI

class NextChecker<T: NavigationCoordinatable>: ObservableObject {
    var cancellables: Set<AnyCancellable> = Set()
    
    @Published var nextIsActive: Bool
    let id: Int?
    weak var t: T?
    let children: Children
    
    private static func calculateNextIsActive(t: T, id: Int?, children: Children) -> Bool {
        if (id ?? 0 == t.navigationStack.value.count) {
            if children.activeChildCoordinator != nil {
                return true
            }
        }
        
        guard let id = id else {
            return (t.navigationStack.value[safe: 0] != nil)
        }
        
        return (t.navigationStack.value[safe: id + 1] != nil)
    }
    
    func nextView() -> AnyView {
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
                id: id ?? -1 + 1,
                coordinator: t!
            )
            .environmentObject(ParentCoordinator(coordinator: t!))
        )
    }
    
    init(id: Int?, _ t: T, children: Children) {
        self.id = id
        self.t = t
        self.children = children
        
        nextIsActive = Self.calculateNextIsActive(
            t: t,
            id: id,
            children: children
        )
        
        t.navigationStack.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let next = Self.calculateNextIsActive(
                    t: t,
                    id: id,
                    children: children
                )
                
                if self.nextIsActive != next {
                    self.nextIsActive = next
                }
            }
        }.store(in: &cancellables)
        
        children.objectWillChange.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let next = Self.calculateNextIsActive(
                    t: t,
                    id: id,
                    children: children
                )
                
                if self.nextIsActive != next {
                    self.nextIsActive = next
                }
            }
        }.store(in: &cancellables)
    }
}
