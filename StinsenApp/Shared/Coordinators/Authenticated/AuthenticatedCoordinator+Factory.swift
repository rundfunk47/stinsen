import Foundation
import SwiftUI
import Stinsen

extension AuthenticatedCoordinator {
    func makeTestbed()  -> NavigationViewCoordinator<TestbedEnvironmentObjectCoordinator> {
        return NavigationViewCoordinator(TestbedEnvironmentObjectCoordinator())
    }
    
    @ViewBuilder func makeTestbedTab(isActive: Bool) -> some View {
        Image(systemName: "bed.double" + (isActive ? ".fill" : ""))
        Text("Testbed")
    }

    func makeHome() -> NavigationViewCoordinator<HomeCoordinator> {
        return NavigationViewCoordinator(HomeCoordinator(todosStore: todosStore))
    }
    
    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        Image(systemName: "house" + (isActive ? ".fill" : ""))
        Text("Home")
    }
    
    func makeTodos() -> NavigationViewCoordinator<TodosCoordinator> {
        return NavigationViewCoordinator(TodosCoordinator(todosStore: todosStore))
    }
    
    @ViewBuilder func makeTodosTab(isActive: Bool) -> some View {
        Image(systemName: "folder" + (isActive ? ".fill" : ""))
        Text("Todos")
    }
    
    func makeProfile() -> NavigationViewCoordinator<ProfileCoordinator> {
        return NavigationViewCoordinator(ProfileCoordinator(user: user))
    }
    
    @ViewBuilder func makeProfileTab(isActive: Bool) -> some View {
        Image(systemName: "person.crop.circle" + (isActive ? ".fill" : ""))
        Text("Profile")
    }
}
