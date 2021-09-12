import Foundation
import SwiftUI
import Combine

struct NavigationCoordinatableView<T: NavigationCoordinatable>: View {
    var coordinator: T
    private let id: Int
    private let router: NavigationRouter<T>
    private let start: AnyView
    @ObservedObject var presentationHelper: PresentationHelper<T>
    
    var body: some View {
        #if os(macOS)
        commonView
            .environmentObject(router)
        #else
        if #available(iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            commonView
                .environmentObject(router)
                .background(
                    // WORKAROUND for iOS < 14.5
                    // A bug hinders us from using modal and fullScreenCover on the same view
                    Color
                        .clear
                        .fullScreenCover(isPresented: Binding<Bool>.init(get: { () -> Bool in
                            return presentationHelper.presented?.type.isFullScreen == true
                        }, set: { _ in
                            self.coordinator.appear(self.id)
                        }), onDismiss: {
                            let presented = self.coordinator.stack.value[safe: id + 1]
                            
                            #warning("fix dismissal")
                            /*
                            switch presented?.presentationType {
                            case .fullScreen:
                                if let presentable = presentable as? AnyCoordinatable {
                                    DispatchQueue.main.async {
                                        presentable.dismissalAction?()
                                        presentable.dismissalAction = nil
                                    }
                                }
                            default:
                                break
                            }
                             */
                            
                            //self.coordinator.popTo(self.id)
                        }, content: { () -> AnyView in
                            return { () -> AnyView in
                                if let view = presentationHelper.presented?.view {
                                    #warning("fix dismissal")
                                    return AnyView(view/*.environmentObject(root)*/)
                                } else {
                                    return AnyView(EmptyView())
                                }
                            }()
                        })
                        .environmentObject(router)
                )
        } else {
            commonView
                .environmentObject(router)
        }
        #endif
    }
    
    @ViewBuilder
    var commonView: some View {
        self.start
            .onAppear(perform: {
                #warning("fix dismissal")
            })
            .background(
                NavigationLink(
                    destination: { () -> AnyView in
                        if let view = presentationHelper.presented?.view {
                            #warning("fix dismissal")
                            return AnyView(view/*.environmentObject(root)*/)
                        } else {
                            return AnyView(EmptyView())
                        }
                    }(),
                    isActive: Binding<Bool>.init(get: { () -> Bool in
                        return presentationHelper.presented?.type.isPush == true
                    }, set: { _ in
                        self.coordinator.appear(self.id)
                    }),
                    label: {
                        EmptyView()
                    }
                )
                .hidden()
            )
            .onDisappear {
                #warning("fix dismissal")
                /*
                self.coordinator.dismissalAction?()
                self.coordinator.dismissalAction = nil
                */
            }
            .sheet(isPresented: Binding<Bool>.init(get: { () -> Bool in
                return presentationHelper.presented?.type.isModal == true
            }, set: { _ in
                self.coordinator.appear(self.id)
            }), onDismiss: {
                // shouldn't matter if different coordinators. also this set modal children to nil
                let presented = self.coordinator.stack.value[safe: id + 1]
                
                #warning("fix dismissal")
                /*
                switch presented?.presentationType {
                case .modal:
                    if let presentable = presentable as? AnyCoordinatable {
                        DispatchQueue.main.async {
                            presentable.dismissalAction?()
                            presentable.dismissalAction = nil
                        }
                    }
                default:
                    break
                }
                 */
            }, content: { () -> AnyView in
                return { () -> AnyView in
                    if let view = presentationHelper.presented?.view {
                        return AnyView(view/*.environmentObject(root)*/)
                    } else {
                        return AnyView(EmptyView())
                    }
                }()
            })
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

        RouterStore.shared.store(router: router)

        if let presentation = coordinator.stack.value[safe: id] {
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
