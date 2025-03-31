import Foundation
import Combine
import SwiftUI

final class PresentationHelper<T: NavigationCoordinatable>: ObservableObject {
    private let id: Int
    private var cancellables = Set<AnyCancellable>()

    let viewControllerSubject = CurrentValueSubject<WeakRef<UIViewController>, Never>(.empty)
    let presentedSubject = CurrentValueSubject<Presented?, Never>(nil)

    func setupViewController(_ viewController: UIViewController) {
        viewControllerSubject.send(WeakRef(value: viewController))
    }

    func setupPresented(coordinator: T, value: [NavigationStackItem]) {
        let nextId = id + 1
        // Only apply updates on last screen in navigation stack
        // This check is important to get the behaviour as using a bool-state in the view that you set
        guard value.count - 1 == nextId, isEmptyPresented, let value = value[safe: nextId] else { return }

        let presentable = value.presentable
        presentedSubject.send(value.presentationType.makePresented(
            presentable: presentable,
            nextId: nextId,
            coordinator: coordinator
        ))
    }

    init(id: Int, coordinator: T) {
        self.id = id
        let navigationStack = coordinator.stack

        setupPresented(coordinator: coordinator, value: navigationStack.value)

        navigationStack
            .changedValue
            .receive(on: DispatchQueue.main)
            .sink { [weak self, coordinator] items in
                self?.setupPresented(coordinator: coordinator, value: items)
            }
            .store(in: &cancellables)

        navigationStack.poppedTo
            .filter { int -> Bool in int <= id }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] int in
                // remove any and all presented views if my id is less than or equal to the view being popped to!
                self?.removePresented()

            }
            .store(in: &cancellables)

        viewControllerSubject
            .removeDuplicates()
            .combineLatest(presentedSubject)
            .sink { [weak self, weak coordinator] in
                guard let parent = $0.value else { return }
                $1?.present(
                    parent: parent,
                    onAppear: { coordinator?.appear(id) },
                    onDisappear: { coordinator?.disappear(id) }
                )
            }
            .store(in: &cancellables)
    }

    func removePresented() {
        if case let .viewController(presented) = presentedSubject.value {
            presented.dismiss()
        }
        presentedSubject.send(nil)
    }
}

private extension PresentationHelper {
    var isEmptyPresented: Bool {
       presentedSubject.value == nil
   }
}

private extension Presented {
    func present(parent: UIViewController, onAppear: @escaping () -> Void, onDisappear: @escaping () -> Void) {
        guard case let .viewController(uiKitPresented) = self,
              let destination = uiKitPresented.viewController else { return }
        uiKitPresented.presentationType.presented(
            parent: parent,
            content: destination,
            onAppeared: onAppear,
            onDissmissed: onDisappear
        )
    }
}
