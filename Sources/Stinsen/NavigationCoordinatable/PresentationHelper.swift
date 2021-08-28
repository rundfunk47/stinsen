import Foundation
import Combine
import SwiftUI

class PresentationHelper<T: NavigationCoordinatable>: ObservableObject {
    private let id: Int
    let navigationStack: NavigationStack
    private var cancellables = Set<AnyCancellable>()
    
    @Published var presented: Presented?
    
    init(id: Int, coordinator: T) {
        self.id = id
        self.navigationStack = coordinator.navigationStack
        
        navigationStack.$value.sink { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let value = self.navigationStack.value
                
                let nextId = id + 1
                
                // Only apply updates on last screen in navigation stack
                // This check is important to get the behaviour as using a bool-state in the view that you set
                if value.count - 1 == nextId, self.presented == nil {
                    if let value = value[safe: nextId] {
                        switch value {
                        case .modal(let presentable):
                            if presentable is AnyView {
                                let view = AnyView(NavigationCoordinatableView(id: nextId, coordinator: coordinator))

                                #if os(macOS)
                                self.presented = .modal(
                                    AnyView(
                                        NavigationView(
                                            content: {
                                                view
                                            }
                                        )
                                    )
                                )
                                #else
                                self.presented = .modal(
                                    AnyView(
                                        NavigationView(
                                            content: {
                                                #if os(macOS)
                                                view
                                                #else
                                                view.navigationBarHidden(true)
                                                #endif
                                            }
                                        )
                                        .navigationViewStyle(StackNavigationViewStyle())
                                    )
                                )
                                #endif
                            } else if let presentable = presentable as? AnyCoordinatable {
                                self.presented = .modal(
                                    AnyView(
                                        presentable.coordinatorView()
                                    )
                                )
                            } else {
                                fatalError("Unsupported presentable!")
                            }
                        case .push(let presentable):
                            if presentable is AnyView {
                                let view = AnyView(NavigationCoordinatableView(id: nextId, coordinator: coordinator))

                                self.presented = .push(
                                    view
                                )
                            } else if let presentable = presentable as? AnyCoordinatable {
                                self.presented = .push(
                                    AnyView(
                                        presentable.coordinatorView()
                                    )
                                )
                            } else {
                                fatalError("Unsupported presentable!")
                            }
                        case .fullScreen(let presentable):
                            if #available(iOS 14, tvOS 14, watchOS 7, *) {
                                if presentable is AnyView {
                                    let view = AnyView(NavigationCoordinatableView(id: nextId, coordinator: coordinator))

                                    #if os(macOS)
                                    self.presented = .fullScreen(
                                        AnyView(
                                            NavigationView(
                                                content: {
                                                    view
                                                }
                                            )
                                        )
                                    )
                                    #else
                                    self.presented = .fullScreen(
                                        AnyView(
                                            NavigationView(
                                                content: {
                                                    #if os(macOS)
                                                    view
                                                    #else
                                                    view.navigationBarHidden(true)
                                                    #endif
                                                }
                                            )
                                            .navigationViewStyle(StackNavigationViewStyle())
                                        )
                                    )
                                    #endif
                                } else if let presentable = presentable as? AnyCoordinatable {
                                    self.presented = .fullScreen(
                                        AnyView(
                                            presentable.coordinatorView()
                                        )
                                    )
                                }  else {
                                    fatalError("Unsupported presentable!")
                                }
                            } else {
                                fatalError("Unsupported presentable!")
                            }
                            
                        }
                    } else {
                        fatalError()
                    }
                }
            }
        }
        .store(in: &cancellables)
        
        navigationStack.poppedTo.filter { int -> Bool in int <= id }.sink { [weak self] int in
            // remove any and all presented views if my id is less than or equal to the view being popped to!
            DispatchQueue.main.async { [weak self] in
                self?.presented = nil
            }
        }
        .store(in: &cancellables)
    }
}
